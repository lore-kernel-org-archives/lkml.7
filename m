Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D7BC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFEF20684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559831252;
	bh=YTbef3FvFKe2GsGHOo89NJrG+tTsjZZWyqwHqfe7Q+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MPWbG1zlaHoFDDC6TJ1AAWpK2fCoOiOJhVBT+1rPjrueotNjevfs2NPSefStqXkNi
	 1vZ0H3jfXNMLSJcP1uFRzpPieqovkFG8GLAptJmxwsZ8m8JAYGCl57JYvoOYsiBlBH
	 s+0ahr2I8/GiFkeWyAvwa3s4YJD3+N5HVxDpGFcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfFFO1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfFFO1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:27:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE51320665;
        Thu,  6 Jun 2019 14:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559831249;
        bh=YTbef3FvFKe2GsGHOo89NJrG+tTsjZZWyqwHqfe7Q+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qD5swS4+kfog1cpjdyhiJh8iUgUAniNfx7ltHlLMFC9Loq0rkE+VsVyPvEtyKmcht
         sILxQWrBfKL3qK+00zU0O6dPzgGGeHi7DV6zL0a7R9+6Hgt4ggGTaYZjgKuzoAfS95
         LDdZu/j4npE3d71Y4LzNgpa+5428A7bvU/BwGS7Q=
Date:   Thu, 6 Jun 2019 16:27:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal/usb: Replace kill_pid_info_as_cred with
 kill_pid_usb_asyncio
Message-ID: <20190606142727.GA10785@kroah.com>
References: <Pine.LNX.4.44L0.1905181116330.7855-100000@netrider.rowland.org>
 <877eakou9o.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877eakou9o.fsf@xmission.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 07:40:35AM -0500, Eric W. Biederman wrote:
> 
> The usb support for asyncio encoded one of it's values in the wrong
> field.  It should have used si_value but instead used si_addr which is
> not present in the _rt union member of struct siginfo.
> 
> The practical result of this is that on a 64bit big endian kernel
> when delivering a signal to a 32bit process the si_addr field
> is set to NULL, instead of the expected pointer value.
> 
> This issue can not be fixed in copy_siginfo_to_user32 as the usb
> usage of the the _sigfault (aka si_addr) member of the siginfo
> union when SI_ASYNCIO is set is incompatible with the POSIX and
> glibc usage of the _rt member of the siginfo union.
> 
> Therefore replace kill_pid_info_as_cred with kill_pid_usb_asyncio a
> dedicated function for this one specific case.  There are no other
> users of kill_pid_info_as_cred so this specialization should have no
> impact on the amount of code in the kernel.  Have kill_pid_usb_asyncio
> take instead of a siginfo_t which is difficult and error prone, 3
> arguments, a signal number, an errno value, and an address enconded as
> a sigval_t.  The encoding of the address as a sigval_t allows the
> code that reads the userspace request for a signal to handle this
> compat issue along with all of the other compat issues.
> 
> Add BUILD_BUG_ONs in kernel/signal.c to ensure that we can now place
> the pointer value at the in si_pid (instead of si_addr).  That is the
> code now verifies that si_pid and si_addr always occur at the same
> location.  Further the code veries that for native structures a value
> placed in si_pid and spilling into si_uid will appear in userspace in
> si_addr (on a byte by byte copy of siginfo or a field by field copy of
> siginfo).  The code also verifies that for a 64bit kernel and a 32bit
> userspace the 32bit pointer will fit in si_pid.
> 
> I have used the usbsig.c program below written by Alan Stern and
> slightly tweaked by me to run on a big endian machine to verify the
> issue exists (on sparc64) and to confirm the patch below fixes the issue.
> 
> /* usbsig.c -- test USB async signal delivery */
> 
> static struct usbdevfs_urb urb;
> static struct usbdevfs_disconnectsignal ds;
> static volatile sig_atomic_t done = 0;
> 
> void urb_handler(int sig, siginfo_t *info , void *ucontext)
> {
> 	printf("Got signal %d, signo %d errno %d code %d addr: %p urb: %p\n",
> 	       sig, info->si_signo, info->si_errno, info->si_code,
> 	       info->si_addr, &urb);
> 
> 	printf("%s\n", (info->si_addr == &urb) ? "Good" : "Bad");
> }
> 
> void ds_handler(int sig, siginfo_t *info , void *ucontext)
> {
> 	printf("Got signal %d, signo %d errno %d code %d addr: %p ds: %p\n",
> 	       sig, info->si_signo, info->si_errno, info->si_code,
> 	       info->si_addr, &ds);
> 
> 	printf("%s\n", (info->si_addr == &ds) ? "Good" : "Bad");
> 	done = 1;
> }
> 
> int main(int argc, char **argv)
> {
> 	char *devfilename;
> 	int fd;
> 	int rc;
> 	struct sigaction act;
> 	struct usb_ctrlrequest *req;
> 	void *ptr;
> 	char buf[80];
> 
> 	if (argc != 2) {
> 		fprintf(stderr, "Usage: usbsig device-file-name\n");
> 		return 1;
> 	}
> 
> 	devfilename = argv[1];
> 	fd = open(devfilename, O_RDWR);
> 	if (fd == -1) {
> 		perror("Error opening device file");
> 		return 1;
> 	}
> 
> 	act.sa_sigaction = urb_handler;
> 	sigemptyset(&act.sa_mask);
> 	act.sa_flags = SA_SIGINFO;
> 
> 	rc = sigaction(SIGUSR1, &act, NULL);
> 	if (rc == -1) {
> 		perror("Error in sigaction");
> 		return 1;
> 	}
> 
> 	act.sa_sigaction = ds_handler;
> 	sigemptyset(&act.sa_mask);
> 	act.sa_flags = SA_SIGINFO;
> 
> 	rc = sigaction(SIGUSR2, &act, NULL);
> 	if (rc == -1) {
> 		perror("Error in sigaction");
> 		return 1;
> 	}
> 
> 	memset(&urb, 0, sizeof(urb));
> 	urb.type = USBDEVFS_URB_TYPE_CONTROL;
> 	urb.endpoint = USB_DIR_IN | 0;
> 	urb.buffer = buf;
> 	urb.buffer_length = sizeof(buf);
> 	urb.signr = SIGUSR1;
> 
> 	req = (struct usb_ctrlrequest *) buf;
> 	req->bRequestType = USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE;
> 	req->bRequest = USB_REQ_GET_DESCRIPTOR;
> 	req->wValue = htole16(USB_DT_DEVICE << 8);
> 	req->wIndex = htole16(0);
> 	req->wLength = htole16(sizeof(buf) - sizeof(*req));
> 
> 	rc = ioctl(fd, USBDEVFS_SUBMITURB, &urb);
> 	if (rc == -1) {
> 		perror("Error in SUBMITURB ioctl");
> 		return 1;
> 	}
> 
> 	rc = ioctl(fd, USBDEVFS_REAPURB, &ptr);
> 	if (rc == -1) {
> 		perror("Error in REAPURB ioctl");
> 		return 1;
> 	}
> 
> 	memset(&ds, 0, sizeof(ds));
> 	ds.signr = SIGUSR2;
> 	ds.context = &ds;
> 	rc = ioctl(fd, USBDEVFS_DISCSIGNAL, &ds);
> 	if (rc == -1) {
> 		perror("Error in DISCSIGNAL ioctl");
> 		return 1;
> 	}
> 
> 	printf("Waiting for usb disconnect\n");
> 	while (!done) {
> 		sleep(1);
> 	}
> 
> 	close(fd);
> 	return 0;
> }
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Oliver Neukum <oneukum@suse.com>
> Fixes: v2.3.39
> Cc: stable@vger.kernel.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---

Ugh, what a mess, thanks for doing this work:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

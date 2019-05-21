Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B46C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD942173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfEUOrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:47:51 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57955 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfEUOrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:47:49 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hT63P-0005gm-2v; Tue, 21 May 2019 08:47:47 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hT63C-0004QZ-9X; Tue, 21 May 2019 08:47:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.1905211000310.1634-100000@iolanthe.rowland.org>
Date:   Tue, 21 May 2019 09:47:29 -0500
In-Reply-To: <Pine.LNX.4.44L0.1905211000310.1634-100000@iolanthe.rowland.org>
        (Alan Stern's message of "Tue, 21 May 2019 10:02:43 -0400 (EDT)")
Message-ID: <87zhnfooe6.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hT63C-0004QZ-9X;;;mid=<87zhnfooe6.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+/c3NBIL+ppiSxLizbCrB9d9a8MdWVWbM=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] signal/usb: Replace kill_pid_info_as_cred with kill_pid_usb_asyncio
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Tue, 21 May 2019, Eric W. Biederman wrote:
>
>> The usb support for asyncio encoded one of it's values in the wrong
>> field.  It should have used si_value but instead used si_addr which is
>> not present in the _rt union member of struct siginfo.
>> 
>> The practical result of this is that on a 64bit big endian kernel
>> when delivering a signal to a 32bit process the si_addr field
>> is set to NULL, instead of the expected pointer value.
>> 
>> This issue can not be fixed in copy_siginfo_to_user32 as the usb
>> usage of the the _sigfault (aka si_addr) member of the siginfo
>> union when SI_ASYNCIO is set is incompatible with the POSIX and
>> glibc usage of the _rt member of the siginfo union.
>> 
>> Therefore replace kill_pid_info_as_cred with kill_pid_usb_asyncio a
>> dedicated function for this one specific case.  There are no other
>> users of kill_pid_info_as_cred so this specialization should have no
>> impact on the amount of code in the kernel.  Have kill_pid_usb_asyncio
>> take instead of a siginfo_t which is difficult and error prone, 3
>> arguments, a signal number, an errno value, and an address enconded as
>> a sigval_t.  The encoding of the address as a sigval_t allows the
>> code that reads the userspace request for a signal to handle this
>> compat issue along with all of the other compat issues.
>> 
>> Add BUILD_BUG_ONs in kernel/signal.c to ensure that we can now place
>> the pointer value at the in si_pid (instead of si_addr).  That is the
>> code now verifies that si_pid and si_addr always occur at the same
>> location.  Further the code veries that for native structures a value
>> placed in si_pid and spilling into si_uid will appear in userspace in
>> si_addr (on a byte by byte copy of siginfo or a field by field copy of
>> siginfo).  The code also verifies that for a 64bit kernel and a 32bit
>> userspace the 32bit pointer will fit in si_pid.
>> 
>> I have used the usbsig.c program below written by Alan Stern and
>> slightly tweaked by me to run on a big endian machine to verify the
>> issue exists (on sparc64) and to confirm the patch below fixes the issue.
>> 
>> /* usbsig.c -- test USB async signal delivery */

Sigh git commit ate the includes...

>> static struct usbdevfs_urb urb;
>> static struct usbdevfs_disconnectsignal ds;
>> static volatile sig_atomic_t done = 0;
>> 
>> void urb_handler(int sig, siginfo_t *info , void *ucontext)
>> {
>> 	printf("Got signal %d, signo %d errno %d code %d addr: %p urb: %p\n",
>> 	       sig, info->si_signo, info->si_errno, info->si_code,
>> 	       info->si_addr, &urb);
>> 
>> 	printf("%s\n", (info->si_addr == &urb) ? "Good" : "Bad");
>> }
>> 
>> void ds_handler(int sig, siginfo_t *info , void *ucontext)
>> {
>> 	printf("Got signal %d, signo %d errno %d code %d addr: %p ds: %p\n",
>> 	       sig, info->si_signo, info->si_errno, info->si_code,
>> 	       info->si_addr, &ds);
>> 
>> 	printf("%s\n", (info->si_addr == &ds) ? "Good" : "Bad");
>> 	done = 1;
>> }
>> 
>> int main(int argc, char **argv)
>> {
>> 	char *devfilename;
>> 	int fd;
>> 	int rc;
>> 	struct sigaction act;
>> 	struct usb_ctrlrequest *req;
>> 	void *ptr;
>> 	char buf[80];
>> 
>> 	if (argc != 2) {
>> 		fprintf(stderr, "Usage: usbsig device-file-name\n");
>> 		return 1;
>> 	}
>> 
>> 	devfilename = argv[1];
>> 	fd = open(devfilename, O_RDWR);
>> 	if (fd == -1) {
>> 		perror("Error opening device file");
>> 		return 1;
>> 	}
>> 
>> 	act.sa_sigaction = urb_handler;
>> 	sigemptyset(&act.sa_mask);
>> 	act.sa_flags = SA_SIGINFO;
>> 
>> 	rc = sigaction(SIGUSR1, &act, NULL);
>> 	if (rc == -1) {
>> 		perror("Error in sigaction");
>> 		return 1;
>> 	}
>> 
>> 	act.sa_sigaction = ds_handler;
>> 	sigemptyset(&act.sa_mask);
>> 	act.sa_flags = SA_SIGINFO;
>> 
>> 	rc = sigaction(SIGUSR2, &act, NULL);
>> 	if (rc == -1) {
>> 		perror("Error in sigaction");
>> 		return 1;
>> 	}
>> 
>> 	memset(&urb, 0, sizeof(urb));
>> 	urb.type = USBDEVFS_URB_TYPE_CONTROL;
>> 	urb.endpoint = USB_DIR_IN | 0;
>> 	urb.buffer = buf;
>> 	urb.buffer_length = sizeof(buf);
>> 	urb.signr = SIGUSR1;
>> 
>> 	req = (struct usb_ctrlrequest *) buf;
>> 	req->bRequestType = USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE;
>> 	req->bRequest = USB_REQ_GET_DESCRIPTOR;
>> 	req->wValue = htole16(USB_DT_DEVICE << 8);
>> 	req->wIndex = htole16(0);
>> 	req->wLength = htole16(sizeof(buf) - sizeof(*req));
>
> In fact, these values are supposed to be in host-endian order, not 
> necessarily little-endian.  The USB core converts them if necessary.

Please look again.  In include/uapi/linux/ch9.h those fields are
explicitly defined as little endian and the code in devio.c for
USBDEVFS_URB_TYPE_CONTROL treats them as little endian.   Perhaps there
is a mismatch here but I haven't seen it and I needed this change to get
the code to work on big endian.

>> 	rc = ioctl(fd, USBDEVFS_SUBMITURB, &urb);
>> 	if (rc == -1) {
>> 		perror("Error in SUBMITURB ioctl");
>> 		return 1;
>> 	}
>> 
>> 	rc = ioctl(fd, USBDEVFS_REAPURB, &ptr);
>> 	if (rc == -1) {
>> 		perror("Error in REAPURB ioctl");
>> 		return 1;
>> 	}
>> 
>> 	memset(&ds, 0, sizeof(ds));
>> 	ds.signr = SIGUSR2;
>> 	ds.context = &ds;
>> 	rc = ioctl(fd, USBDEVFS_DISCSIGNAL, &ds);
>> 	if (rc == -1) {
>> 		perror("Error in DISCSIGNAL ioctl");
>> 		return 1;
>> 	}
>> 
>> 	printf("Waiting for usb disconnect\n");
>> 	while (!done) {
>> 		sleep(1);
>> 	}
>> 
>> 	close(fd);
>> 	return 0;
>> }
>> 
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-usb@vger.kernel.org
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: Oliver Neukum <oneukum@suse.com>
>> Fixes: v2.3.39
>> Cc: stable@vger.kernel.org
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>> 
>> I managed to wrestle a sparc64 qemu to the ground so I could verify this
>> bug exists and the patch below fixes it.
>> 
>> Can I get an Ack from the usb side of things?
>
> Give me some time to review the description and the changes.

Please, it always helps when more people understand these things.

Eric

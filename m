Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BD1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7371A2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553855170;
	bh=6g9MbCmIADEI4jCTMUG2++YuR1o3haQcloefBzwY8m8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NHeDxKJ0qYQ/k8oGPsdQjMgcQQnMcqKjTdpCkYbD/4Uaic5XNAHGK73USvOwdsuQO
	 3w8OrlSK9Qy148jt6wWzlal9wxxHp8/xX7weR6FvGecTZSIOipDCEOooNlI8Otih2G
	 Tg8fjIBiMIEelNESKY7AEkRrgxr6IJIxjnaCFybc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfC2K0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728693AbfC2K0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:26:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2F2B206B8;
        Fri, 29 Mar 2019 10:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553855168;
        bh=6g9MbCmIADEI4jCTMUG2++YuR1o3haQcloefBzwY8m8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYNvIKUL0GNh9dCvMKxlPrEwOiOEzqt0EoCMPEmeVum25id3aLq56BrI5birRawjU
         0z2sYuLBUxmLA+sQTc4OGdIG13OQffuZDgtqEfRLc+XtPwpxg7VAkTz2HtFEwF7tmg
         tE2UogE0OBuNLozd1a0fJdjl2prnKyLjT37V4VQA=
Date:   Fri, 29 Mar 2019 11:26:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Pavel Machek <pavel@ucw.cz>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: kernfs: can read/write method grow buffer size?
Message-ID: <20190329102606.GB7286@kroah.com>
References: <20190329040922.34ab01c6@nic.cz>
 <20190329062253.GA9659@kroah.com>
 <20190329083440.GA12945@amd>
 <20190329094823.426d7ed8@nic.cz>
 <20190329102436.GA7286@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329102436.GA7286@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 11:24:36AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 29, 2019 at 09:48:23AM +0100, Marek Behun wrote:
> > > pavel@amd:~/cip$ cat /sys/power/state
> > > freeze mem disk
> > > pavel@amd:~/cip$ cat /sys/class/leds/phy0-led/trigger
> > > none bluetooth-power rfkill-any rfkill-none kbd-scrolllock kbd-numlock
> > > kbd-capslock kbd-kanalock kbd-shiftlock kbd-altgrlock kbd-ctrllock
> > > kbd-altlock kbd-shiftllock kbd-shiftrlock kbd-ctrlllock kbd-ctrlrlock
> > > AC-online BAT0-charging-or-full BAT0-charging BAT0-full
> > > BAT0-charging-blink-full-solid rfkill0 phy0rx phy0tx phy0assoc
> > > phy0radio [phy0tpt] mmc0 timer heartbeat audio-mute audio-micmute
> > > rfkill1 hci0-power rfkill8
> > > pavel@amd:~/cip$
> > > 
> > 
> > Yes, and cpufreq governors too list available governosrs as space
> > separated list.
> > Maybe the "one value per file" rule was thought-of only after these
> > were merged?
> 
> For small numbers of things, like /sys/power/state, which was the first
> file to use this style, it was fine as we "knew" this was going to be a
> small, well-bounded list of states that the file could be in.
> 
> As you have seen, 'trigger' is not that, and I am pretty sure I have
> complained about this in the past.
> 
> I suggest you use a different way of "discovering" what types of
> triggers are available.  I don't know what would work best for you, but
> any time you are ever worried about the size of a sysfs file's buffer,
> you know you are doing something wrong.

Ok, while writing this out, I realized that to keep things still
working, and to enable you to have an unlimited list of triggers, why
not just turn the file into a binary sysfs file?

Yes, that's not what binary sysfs files are for, they are supposed to be
only used for data that is "pass through" from userspace to hardware,
where the kernel does not touch the information at all.  But I'm willing
to give you an exception here as long as you document the heck out of it
in the code itself, saying that no one else should ever copy this way of
doing things again.

Would that work?

greg k-h

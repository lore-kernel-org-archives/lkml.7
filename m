Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB97C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEF2206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556124664;
	bh=KHWGGy0jMAuVixt+Qml8P+H7UayHUqAzgqVvZJvRnpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QQeURgF4wWt8vB7OP/0ZRG+nuYyF+4DUWgDUlGl6Keg8Q//PHz9rTOk676RJYHyMY
	 E/L/m7U7prKsdb2RJZgBTXpXBmerYzkyG+R83hG0nzy6XLfyh/uwJ8vsVnvF7LdtNx
	 nkHPM1udazwOT1dz6T3SB5lUUT4ofH2VknVBcdVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732882AbfDXQu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732242AbfDXQu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:50:56 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C7C206A3;
        Wed, 24 Apr 2019 16:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556124655;
        bh=KHWGGy0jMAuVixt+Qml8P+H7UayHUqAzgqVvZJvRnpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fE0RcAy7jYUiopBT0sYH4VUqxy4DUVUCqo/yHL/CfjYODRbRmkE0SGnlv7Drse2pW
         Gr0OztmCg02ob2MQ2iV67Yp+MAa+ddSLbbxAWB4XRWqoz1DlkSLWS6H5Ml9xC+QnEN
         ung2og8p46XfAl7sGMc6qVXAkfV+6DLz8QvI+jbI=
Date:   Wed, 24 Apr 2019 18:50:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     "Yang, Fei" <fei.yang@intel.com>, Felipe Balbi <balbi@kernel.org>,
        andrzej.p@collabora.com, Vincent Pelletier <plr.vincent@gmail.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Josh Gao <jmgao@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Shen Jing <jingx.shen@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
Message-ID: <20190424165052.GF21916@kroah.com>
References: <1553059940-127038-1-git-send-email-fei.yang@intel.com>
 <CALAqxLUW9XCq0WqTzpYGZ7B_4CVdsXY6t_dyuwhnOTJ7HajrwQ@mail.gmail.com>
 <CALAqxLUwB4vYiCM1Yi2CizMu-FvEoBB-eNqwaTFi2b=gnvCCZQ@mail.gmail.com>
 <CALAqxLXE2Be_a3utjDP2+0mCfHeEypw_PqJPwkoyDM-F2F=jBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLXE2Be_a3utjDP2+0mCfHeEypw_PqJPwkoyDM-F2F=jBA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:26:51AM +0700, John Stultz wrote:
> On Wed, Mar 20, 2019 at 11:21 AM John Stultz <john.stultz@linaro.org> wrote:
> > On Wed, Mar 20, 2019 at 9:40 AM John Stultz <john.stultz@linaro.org> wrote:
> > > On Tue, Mar 19, 2019 at 10:32 PM <fei.yang@intel.com> wrote:
> > > Elsewhere it seems the ffs driver takes effort to drop any locks
> > > before calling usb_ep_dequeue(), so this seems like that should be
> > > addressed, but it also seems like recent change to the dwc3 driver has
> > > been made to avoid sleeping in that path (see fec9095bdef4 ("usb:
> > > dwc3: gadget: remove wait_end_transfer")), which may be why I'm not
> > > seeing the problem with mainline (and your patch here, of coarse).
> > > But that also doesn't clarify if its still a potential issue w/
> > > non-dwc3 platforms.
> >
> > Felipe: Given Alan's point, does it make sense to mark the commits
> > that remove the possible sleep from wait_event_lock_irq() in
> > dwc3_gadget_ep_dequeue()  for -stable?
> >
> > Against 4.19.30, the following set manages to cherry-pick cleanly:
> > git cherry-pick 1a22ec643580626f439c8583edafdcc73798f2fb
> > git cherry-pick 09fe1f8d7e2f461275b1cdd832f2cfa5e9be346d
> > git cherry-pick c3acd59014148470dc58519870fbc779785b4bf7
> > git cherry-pick 7746a8dfb3f9c91b3a0b63a1d5c2664410e6498d
> > git cherry-pick d5443bbf5fc8f8389cce146b1fc2987cdd229d12
> > git cherry-pick d4f1afe5e896c18ae01099a85dab5e1a198bd2a8
> > git cherry-pick fec9095bdef4e7c988adb603d0d4f92ee735d4a1
> > # To get things building, revert modified -stable fix
> > git revert 25ad17d
> > #pick actual upstream fix replacing the previous
> > git cherry-pick bd6742249b9ca918565e4e3abaa06665e587f4b5
> >
> > (Though I'm always a bit hesitant with -stable backports on subsystems
> > I don't know well. So I'm not sure if this set is fully correct.)
> >
> > This set seems to avoid the crash on reboot I was seeing.
> >
> > And of course, I'm sure getting that set backported to 4.14 and 4.9
> > (and maybe even 4.4, I need to check) will be less clean.
> 
> Also,  I just wanted to follow up on this as well. Does the above set
> of cherry-picks look ok to others for 4.19-stable?  Does anyone have
> suggestions on how they'd like to see backports to 4.14, 4.9 and 4.4?

If they are ok, can someone send me the commits as a series of patches,
as doing the above really doesn't help much :)

thanks,

greg k-h

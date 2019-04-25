Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DFEC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 03:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DCE217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 03:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/mSAoKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389111AbfDYDxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 23:53:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42401 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbfDYDxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 23:53:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so28109699wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 20:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5L3E0HwDDQMhrx+Vj9qrJRYW7q7zSpM0L4v196gNVL0=;
        b=Q/mSAoKFOc4eH9WR+HeVhCdUFLTM6EowQcPIAzhdU1Fcz64uLvLkOML2xA4EyEgejo
         YAI46uPFeUvEFN+hF/CfvFe1ht7ZaEtdTDwSVYXjrroUkeoc09dDl6rgab/iWZM7ASfF
         ZCb0pdzxnaClBJ6t2e3jGOGWpTmyKzBBJHnMQr1eBMeeuKrnzoURRldKICpo64Xhd4aO
         PIFP9h4P464dhYNF4w6y/pA7hjduYuhZjp06bgeB6AIkKq/XdZZgN3nXLLoeOQ62htQX
         DuGeCcZ+ssL3xmXxpcrguoZwFFKloeQnonKvtDHL0SlK/iV+hSS+80AUrLz4PcjnZzpc
         eS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5L3E0HwDDQMhrx+Vj9qrJRYW7q7zSpM0L4v196gNVL0=;
        b=H6Wv0pCCfBatLse329OhMRBgo+9TnxU96WvbW+yZhZ55A3jFh7Qh1zdLSxKfRqjGwS
         zCxCB1lPv/2PVVAIc/j96UoZ8kc5ufFpmGA6zIBNqQw8SYHIxvMIONTa3aqeG+32dfan
         qSqgdCZFWPOaw7HxAzNF8wavEhRHRR2uPojhT0+kW2/UYjtXJuS5UaYCPZLOCKbv9guL
         SWT4HOHxnLDk8eFFkY/TONdEUJrvL+og+CEM/hI1yEd9FetfQh87lZ5EkRBOW1PT0fCv
         LzUUfl2Hzj66sXLJx5Xde2fXIjzV+BAP75eEwHg3W0AP6YlUPck+3ZbQiwxg6E26ynUc
         2mNg==
X-Gm-Message-State: APjAAAWsDUh6HnHANFzxDkwULWT1hb2wT8kKy/TAkpVCOCyRrGCb2Qm4
        xmXdXbvSB7ORk24ZFKFtQDRm/RZ6YAulU6oESGNjvg==
X-Google-Smtp-Source: APXvYqx2g/hH/RX+4k1e4COwiSspRHeePfD6prEQOj89UF5l7J2zPg3tCXtdSe4B6fOTsNadBYx+jNGygCf/m5pbW88=
X-Received: by 2002:a05:6000:118a:: with SMTP id g10mr2609981wrx.233.1556164398224;
 Wed, 24 Apr 2019 20:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <1553059940-127038-1-git-send-email-fei.yang@intel.com>
 <CALAqxLUW9XCq0WqTzpYGZ7B_4CVdsXY6t_dyuwhnOTJ7HajrwQ@mail.gmail.com>
 <CALAqxLUwB4vYiCM1Yi2CizMu-FvEoBB-eNqwaTFi2b=gnvCCZQ@mail.gmail.com>
 <CALAqxLXE2Be_a3utjDP2+0mCfHeEypw_PqJPwkoyDM-F2F=jBA@mail.gmail.com> <20190424165052.GF21916@kroah.com>
In-Reply-To: <20190424165052.GF21916@kroah.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 24 Apr 2019 20:53:06 -0700
Message-ID: <CALAqxLXwoTaWLgw9u_Z6H6fW-a-6DzXAcZkaGBKpkEJAbBtJ5w@mail.gmail.com>
Subject: Re: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Yang, Fei" <fei.yang@intel.com>, Felipe Balbi <balbi@kernel.org>,
        andrzej.p@collabora.com, Vincent Pelletier <plr.vincent@gmail.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Josh Gao <jmgao@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Shen Jing <jingx.shen@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 9:50 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 02, 2019 at 10:26:51AM +0700, John Stultz wrote:
> > On Wed, Mar 20, 2019 at 11:21 AM John Stultz <john.stultz@linaro.org> wrote:
> > > On Wed, Mar 20, 2019 at 9:40 AM John Stultz <john.stultz@linaro.org> wrote:
> > > > On Tue, Mar 19, 2019 at 10:32 PM <fei.yang@intel.com> wrote:
> > > > Elsewhere it seems the ffs driver takes effort to drop any locks
> > > > before calling usb_ep_dequeue(), so this seems like that should be
> > > > addressed, but it also seems like recent change to the dwc3 driver has
> > > > been made to avoid sleeping in that path (see fec9095bdef4 ("usb:
> > > > dwc3: gadget: remove wait_end_transfer")), which may be why I'm not
> > > > seeing the problem with mainline (and your patch here, of coarse).
> > > > But that also doesn't clarify if its still a potential issue w/
> > > > non-dwc3 platforms.
> > >
> > > Felipe: Given Alan's point, does it make sense to mark the commits
> > > that remove the possible sleep from wait_event_lock_irq() in
> > > dwc3_gadget_ep_dequeue()  for -stable?
> > >
> > > Against 4.19.30, the following set manages to cherry-pick cleanly:
> > > git cherry-pick 1a22ec643580626f439c8583edafdcc73798f2fb
> > > git cherry-pick 09fe1f8d7e2f461275b1cdd832f2cfa5e9be346d
> > > git cherry-pick c3acd59014148470dc58519870fbc779785b4bf7
> > > git cherry-pick 7746a8dfb3f9c91b3a0b63a1d5c2664410e6498d
> > > git cherry-pick d5443bbf5fc8f8389cce146b1fc2987cdd229d12
> > > git cherry-pick d4f1afe5e896c18ae01099a85dab5e1a198bd2a8
> > > git cherry-pick fec9095bdef4e7c988adb603d0d4f92ee735d4a1
> > > # To get things building, revert modified -stable fix
> > > git revert 25ad17d
> > > #pick actual upstream fix replacing the previous
> > > git cherry-pick bd6742249b9ca918565e4e3abaa06665e587f4b5
> > >
> > > (Though I'm always a bit hesitant with -stable backports on subsystems
> > > I don't know well. So I'm not sure if this set is fully correct.)
> > >
> > > This set seems to avoid the crash on reboot I was seeing.
> > >
> > > And of course, I'm sure getting that set backported to 4.14 and 4.9
> > > (and maybe even 4.4, I need to check) will be less clean.
> >
> > Also,  I just wanted to follow up on this as well. Does the above set
> > of cherry-picks look ok to others for 4.19-stable?  Does anyone have
> > suggestions on how they'd like to see backports to 4.14, 4.9 and 4.4?
>
> If they are ok, can someone send me the commits as a series of patches,
> as doing the above really doesn't help much :)

Yea, so I'm happy to send that set to you for 4.19, assuming Felipe or
someone else OKs it.
I'm still at a bit of a loss for what to do for older (4.14/4.9/4.4)
-stable kernels, as its going to be difficult to backport those.

thanks
-john

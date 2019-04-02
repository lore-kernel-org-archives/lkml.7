Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92284C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF57207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HBsxJQ3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfDBD1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:27:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37223 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfDBD1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:27:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so1733602wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 20:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BnimVsuh2+zTcP1tvzKSWjLIuouXSxQGtqJWn1IMvlE=;
        b=HBsxJQ3IOkAVlxQdckN67dW0kBgftaw5jCT2f4AqShdD6yg6pNV54K726jN8rBVltG
         yWBB7JEYLCNY+wEZdujSoGBQpY9u5LhOMfL2mL+uYddUkFZ+DOxwgMmXgZK/lOOsIg25
         7oiyTQMY4FyO+Z/x77oHAjXQR+1Gke/h4J7bXjuJUxJjZlvKmK4CQM4vzvfahtl04nvR
         dT1faoJlOswS7cX5HzjG4uJZGtwU+zbP/uSUg9qZA9ODHkNXQIFC7soNHfYEhOSlg/Ea
         zJQQq2GaV6hz/HH9gUh5pyRbxGAiU7GPgzgPfhNtOVX79sO9zqsFXeqiVTvDbwiRqtHU
         j2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnimVsuh2+zTcP1tvzKSWjLIuouXSxQGtqJWn1IMvlE=;
        b=MvBsB+/KUs5Bb5X6NLvV/eKsKSvlHboddX6ZWJPBYc2IjPtKX20JL4AXhfl/shHa5/
         M835pSeOmGtQT1FmapDIDa5LR/K7IwuBjLmgZQrz4ChqrEi2PpNgP4jpLNMhxTsoUQhv
         YQzXskCi4m7yLDRt6GuV+nPk0DNkX4Yn2H4Iv7LAq1NAjLw6MpoaAfyD4dn8OLXnSygE
         5T/eIzspvPHgT/Nhky2Km3wuPCGuDTkXbYKmxuI8eFeT+e5lINRQC6gULNYSbAsuvckE
         x32ZH/ebzWxJePP+BZiHcBmGqYJwLya74yZ779beK94RY4CgKIOan9oWUap39eYpjyGU
         CvQg==
X-Gm-Message-State: APjAAAWmZ+joZ9GJvyv35qSVHhfLGfNWlMQCI6PfW5xxbK4r4vwcznFF
        OCX12+CZOuIWC38yFWmMu0X4fdPOhomN/V6IEERWmg==
X-Google-Smtp-Source: APXvYqy2SGlKu6BHRKH4ka9ltdx8HojhriXfjeNIzwfVvrq3nZqXtQUEPC28HgsOI0JQkVLr6BCFu8e4bFxzW78XZUw=
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr1666963wmh.81.1554175624052;
 Mon, 01 Apr 2019 20:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <1553059940-127038-1-git-send-email-fei.yang@intel.com>
 <CALAqxLUW9XCq0WqTzpYGZ7B_4CVdsXY6t_dyuwhnOTJ7HajrwQ@mail.gmail.com> <CALAqxLUwB4vYiCM1Yi2CizMu-FvEoBB-eNqwaTFi2b=gnvCCZQ@mail.gmail.com>
In-Reply-To: <CALAqxLUwB4vYiCM1Yi2CizMu-FvEoBB-eNqwaTFi2b=gnvCCZQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 2 Apr 2019 10:26:51 +0700
Message-ID: <CALAqxLXE2Be_a3utjDP2+0mCfHeEypw_PqJPwkoyDM-F2F=jBA@mail.gmail.com>
Subject: Re: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
To:     "Yang, Fei" <fei.yang@intel.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, andrzej.p@collabora.com,
        Vincent Pelletier <plr.vincent@gmail.com>,
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

On Wed, Mar 20, 2019 at 11:21 AM John Stultz <john.stultz@linaro.org> wrote:
> On Wed, Mar 20, 2019 at 9:40 AM John Stultz <john.stultz@linaro.org> wrote:
> > On Tue, Mar 19, 2019 at 10:32 PM <fei.yang@intel.com> wrote:
> > Elsewhere it seems the ffs driver takes effort to drop any locks
> > before calling usb_ep_dequeue(), so this seems like that should be
> > addressed, but it also seems like recent change to the dwc3 driver has
> > been made to avoid sleeping in that path (see fec9095bdef4 ("usb:
> > dwc3: gadget: remove wait_end_transfer")), which may be why I'm not
> > seeing the problem with mainline (and your patch here, of coarse).
> > But that also doesn't clarify if its still a potential issue w/
> > non-dwc3 platforms.
>
> Felipe: Given Alan's point, does it make sense to mark the commits
> that remove the possible sleep from wait_event_lock_irq() in
> dwc3_gadget_ep_dequeue()  for -stable?
>
> Against 4.19.30, the following set manages to cherry-pick cleanly:
> git cherry-pick 1a22ec643580626f439c8583edafdcc73798f2fb
> git cherry-pick 09fe1f8d7e2f461275b1cdd832f2cfa5e9be346d
> git cherry-pick c3acd59014148470dc58519870fbc779785b4bf7
> git cherry-pick 7746a8dfb3f9c91b3a0b63a1d5c2664410e6498d
> git cherry-pick d5443bbf5fc8f8389cce146b1fc2987cdd229d12
> git cherry-pick d4f1afe5e896c18ae01099a85dab5e1a198bd2a8
> git cherry-pick fec9095bdef4e7c988adb603d0d4f92ee735d4a1
> # To get things building, revert modified -stable fix
> git revert 25ad17d
> #pick actual upstream fix replacing the previous
> git cherry-pick bd6742249b9ca918565e4e3abaa06665e587f4b5
>
> (Though I'm always a bit hesitant with -stable backports on subsystems
> I don't know well. So I'm not sure if this set is fully correct.)
>
> This set seems to avoid the crash on reboot I was seeing.
>
> And of course, I'm sure getting that set backported to 4.14 and 4.9
> (and maybe even 4.4, I need to check) will be less clean.

Also,  I just wanted to follow up on this as well. Does the above set
of cherry-picks look ok to others for 4.19-stable?  Does anyone have
suggestions on how they'd like to see backports to 4.14, 4.9 and 4.4?

thanks
-john

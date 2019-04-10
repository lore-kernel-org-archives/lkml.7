Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754B3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2402063F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="g46iFH89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbfDJRzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:55:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43199 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729571AbfDJRzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:55:11 -0400
Received: by mail-ot1-f66.google.com with SMTP id u15so2728845otq.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=za2E/pLJgKbwiV1dsXtjcDsjWlrh7jaWMTWufoDKu5o=;
        b=g46iFH89Et3jdAxwN3daHsdlaI1+zHIcOv5/gHFIApHJYqE8yvgRmyHw0Xm9H9cHCg
         IbwNLoYGu7QZ4nov9UfQpYh0y3WNWrStUed2N8aEI+IfeQqjVQKRMuMPbD6nUYfKDe3l
         hHVmaeD7BTnuqlv5g4BM7uFKJGPu9DQxFhsqVExKE2tN2OqMZv/GmMpPer7lq7oV7lLM
         nwAa07MYGs45q9tdLFFzNTJQtSy9jlmVb5G3smCrW7uPw+YMSiqI87FIc9B9Lus+KptW
         N0al/hgirxv4udjxdPowSfRRu0zMzs0t3MGfWPPnRdKgE9/PNVfW3MNBiBi3OQS1bH6Y
         7CmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=za2E/pLJgKbwiV1dsXtjcDsjWlrh7jaWMTWufoDKu5o=;
        b=pl9uqIM2Nysp0l/MAUKv/On+eUMvEQOzGZi+AL3DevBmrkqgFXdkUn45PnbzsvpRGZ
         6UthMo9+hkflqMu+DrcpRsMRXYvsL+lXkwgKUXAu9BeL6Wh3C5YflhFCYeycy8VJnUJq
         mgh2wCnd5M593Mr6Yspd0JInR4xxyPUO2ndub6l6RmLZkzD2w9U/bcKF3+dnQvzCEh4X
         N9x0mx92x72xi6sy6LNfWp682o6IMqHEf3LzFX1LjZP+Y2DIlDQWvJw4BbKMm1saXlhq
         xEe9XjRzGvLVrAEJyf1xcL+WdxNwyffTu+93fJOXkrMKO8EENl078WcWUHku/MkShQKN
         nXsg==
X-Gm-Message-State: APjAAAULAauigWuyAqV07VSN4SDaKXtPojibfw3I7ZYOeYkvRjEKHpg+
        +VPZRqqjkJwCELnH8ClnNXPTK3fB8XlnAovZRxw=
X-Google-Smtp-Source: APXvYqxJCvj+hExhPZ1nr7IT/D4Y0kcPlZk34EZsNBEpynW+ggppXtmmAwRzG91Zbd7EtMxeZ2qI4kfNxCokVL3UhpI=
X-Received: by 2002:a9d:6e88:: with SMTP id a8mr2804549otr.117.1554918910311;
 Wed, 10 Apr 2019 10:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCBOX8HyY-UocsVQvsnTr4XWXyE9oU+f2xhO1=JU0i_9ow@mail.gmail.com>
 <20190321214401.GC19508@bombadil.infradead.org> <CAFBinCA6oK5UhDAt9kva5qRisxr2gxMF26AMK8vC4b1DN5RXrw@mail.gmail.com>
 <5cad2529-8776-687e-58d0-4fb9e2ec59b1@amlogic.com> <CAFBinCA=0XSSVmzfTgb4eSiVFr=XRHqLOVFGyK0++XRty6VjnQ@mail.gmail.com>
 <32799846-b8f0-758f-32eb-a9ce435e0b79@amlogic.com> <CAFBinCDHmuNZxuDf3pe2ij6m8aX2fho7L+B9ZMaMOo28tPZ62Q@mail.gmail.com>
 <79b81748-8508-414f-c08a-c99cb4ae4b2a@amlogic.com> <CAFBinCCSkVGp_iWKf=o=7UGuDUWxyLPGdrqGy_P-HPuEJiU1zQ@mail.gmail.com>
 <8cb108ff-7a72-6db4-660d-33880fcee08a@amlogic.com>
In-Reply-To: <8cb108ff-7a72-6db4-660d-33880fcee08a@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 10 Apr 2019 19:54:59 +0200
Message-ID: <CAFBinCD4cRGbC=cFYEGVAHOtBSvrgNbCSfDWe3To0KCE5+ceVw@mail.gmail.com>
Subject: Re: 32-bit Amlogic (ARM) SoC: kernel BUG in kfree()
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Matthew Wilcox <willy@infradead.org>, mhocko@suse.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        rppt@linux.ibm.com, linux-mm@kvack.org,
        linux-mtd@lists.infradead.org, linux-amlogic@lists.infradead.org,
        akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

On Wed, Apr 10, 2019 at 1:08 PM Liang Yang <liang.yang@amlogic.com> wrote:
>
> Hi Martin,
>
> On 2019/4/5 12:30, Martin Blumenstingl wrote:
> > Hi Liang,
> >
> > On Fri, Mar 29, 2019 at 8:44 AM Liang Yang <liang.yang@amlogic.com> wrote:
> >>
> >> Hi Martin,
> >>
> >> On 2019/3/29 2:03, Martin Blumenstingl wrote:
> >>> Hi Liang,
> >> [......]
> >>>> I don't think it is caused by a different NAND type, but i have followed
> >>>> the some test on my GXL platform. we can see the result from the
> >>>> attachment. By the way, i don't find any information about this on meson
> >>>> NFC datasheet, so i will ask our VLSI.
> >>>> Martin, May you reproduce it with the new patch on meson8b platform ? I
> >>>> need a more clear and easier compared log like gxl.txt. Thanks.
> >>> your gxl.txt is great, finally I can also compare my own results with
> >>> something that works for you!
> >>> in my results (see attachment) the "DATA_IN  [256 B, force 8-bit]"
> >>> instructions result in a different info buffer output.
> >>> does this make any sense to you?
> >>>
> >> I have asked our VLSI designer for explanation or simulation result by
> >> an e-mail. Thanks.
> > do you have any update on this?
> Sorry. I haven't got reply from VLSI designer yet. We tried to improve
> priority yesterday, but i still can't estimate the time. There is no
> document or change list showing the difference between m8/b and gxl/axg
> serial chips. Now it seems that we can't use command NFC_CMD_N2M on nand
> initialization for m8/b chips and use *read byte from NFC fifo register*
> instead.
thank you for the status update!

I am trying to understand your suggestion not to use NFC_CMD_N2M:
the documentation (public S922X datasheet from Hardkernel: [0]) states
that P_NAND_BUF (NFC_REG_BUF in the meson_nand driver) can hold up to
four bytes of data. is this the "read byte from NFC FIFO register" you
mentioned?

Before I spend time changing the code to use the FIFO register I would
like to wait for an answer from your VLSI designer.
Setting the "correct" info buffer length for NFC_CMD_N2M on the 32-bit
SoCs seems like an easier solution compared to switching to the FIFO
register. Keeping NFC_CMD_N2M on the 32-bit SoCs also allows us to
have only one code-path for 32 and 64 bit SoCs, meaning we don't have
to maintain two separate code-paths for basically the same
functionality (assuming that NFC_CMD_N2M is not completely broken on
the 32-bit SoCs, we just don't know how to use it yet).


Regards
Martin


[0] https://dn.odroid.com/S922X/ODROID-N2/Datasheet/S922X_Public_Datasheet_V0.2.pdf

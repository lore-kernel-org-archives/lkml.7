Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F699ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109C021783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UuQs43Oh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbfJAQ7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:59:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45463 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730610AbfJAQlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:41:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id u12so5727847pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWx6wd3DIiucF+Ocv7n1SU0Th5H7npNVE0zzmnuydhU=;
        b=UuQs43OhGgF0e0PCeN/p+BGim5fp57VfMnBxVRhLHeHO42C0dF3FiLIvy2P/KOoTop
         D8wFLFNqlGrIkdQTGbzrWDABccy9iD5K8LOaTOUgKaAeBnr2SjKd5LTOVEqG3ggy+Atd
         IpLG8/E2MXUJuuuCnoCpZpVBNKRXgxBHFYQzlWLH0dvMeyUh+lYw+gVrV1OH3F+sHD3R
         DEJAwubCF+2wV2Ux8GqaRKsQ3Vw46ZO5m2D1jQoWzGYX7TEeFiUE1sbWZo0jWQ0EWQz3
         YGLioif80xqj0BD66Og47ERRZL+RfZ/IrTZZQH1y6Jlvs2I7SmvOr88a99ydT3XDmT21
         BUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWx6wd3DIiucF+Ocv7n1SU0Th5H7npNVE0zzmnuydhU=;
        b=C5bQsziBjb9t7G4OMOHcVl9MMZ2P8EMBc3H6Xkf0K5yR3m2fOuVg8XPmP1pj2xLx6i
         BoRgIP66bKWOJ6lug8je6d9PJVEzM6284Z3A1Iti33QJzzAwEoxr7suDEDv4EApTyWjr
         uofuVY1TN5sQiB7OdjakvcTIH+5U/j9MvfZ74GSZB6NiC76AGmSk1xiysW4uZaVEWVmL
         0rAmhJq1CfB4Gy4hpUJpZkUBB6oQ6tQc5GA8auiWJ1Twv7z6ByIWdEZPBL3z122yIwcp
         rzTXlatrdj7Bx7dLpXTCF5Accb2nGQO7p8LE97D93yr5lex2XOUvyoSMcGf7vlrcjJel
         BasA==
X-Gm-Message-State: APjAAAXj4BNrtGnSjycSa+rPtOznpmZ0P0pzY3nTz3tsUpZDT42hCHbt
        RCLwvUZVYj8BjFIaQIcki1shYflxHAWDufDxAfaSdw==
X-Google-Smtp-Source: APXvYqwEzOWxmDU2hzC1zPRylpvjjoZt28pQ2PYdPEiCuZ7rfM0W+z1jPp1YoebhIrWOl9wxHRIIw7LZrVnkRnisqn8=
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr26531027plp.336.1569948065411;
 Tue, 01 Oct 2019 09:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000927a7b0586561537@google.com> <MN2PR18MB263783F52CAD4A335FD8BB34A01A0@MN2PR18MB2637.namprd18.prod.outlook.com>
 <CACT4Y+aQzBkAq86Hx4jNFnAUzjXnq8cS2NZKfeCaFrZa__g-cg@mail.gmail.com>
 <MN2PR18MB26372D98386D79736A7947EEA0140@MN2PR18MB2637.namprd18.prod.outlook.com>
 <MN2PR18MB263710E8F1F8FFA06B2EDB3CA0EC0@MN2PR18MB2637.namprd18.prod.outlook.com>
 <CAAeHK+z8MBNikw_x50Crf8ZhOhcF=uvPHakvBx44K77xHRUNfg@mail.gmail.com>
 <87k1bhb20j.fsf@kamboji.qca.qualcomm.com> <MN2PR18MB263724E4791927DF1AE009B1A0AD0@MN2PR18MB2637.namprd18.prod.outlook.com>
In-Reply-To: <MN2PR18MB263724E4791927DF1AE009B1A0AD0@MN2PR18MB2637.namprd18.prod.outlook.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 1 Oct 2019 18:40:53 +0200
Message-ID: <CAAeHK+w6Po=8cYRDXZBHY6ZpFLc_ysmxsuGmxGzpvfdZw6ySrw@mail.gmail.com>
Subject: Re: [EXT] INFO: trying to register non-static key in del_timer_sync (2)
To:     Ganapathi Bhat <gbhat@marvell.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+dc4127f950da51639216@syzkaller.appspotmail.com>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "nishants@marvell.com" <nishants@marvell.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 4:08 PM Ganapathi Bhat <gbhat@marvell.com> wrote:
>
> Hi Dmitry/Kalle,
>
> > >>
> > >> Hi Dmitry,
> > >>
> > >> We have a patch to fix this:
> > >> https://patchwork.kernel.org/patch/10990275/
> > >
> > > Hi Ganapathi,
> > >
> > > Has this patch been accepted anywhere? This bug is still open on syzbot.
> >
> > The patch is in "Changes Requested" state which means that the author is
> > supposed to send a new version based on the review comments.
> We will address the review comments and try to push the updated version soon;

Hi Ganapathi,

I was wondering if you've posted the updated version of the fix?

Thanks!

Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4452ECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C622214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Prqdct9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389585AbfJ1Nic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:38:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43481 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbfJ1Nic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:38:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id l24so6881411pgh.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wGuG1asRy1Pd6i7LZD0Q+1ycYN3PhkFDWywCgQeZeaY=;
        b=Prqdct9iwqd6MXUyCkYp/bYuS5H5kh75fxMDBkRg1GIZvSnA0QDrplJypF3PpZH/O4
         1Bp+n8ikRLiZi3wCtGM5EdYBOUSz43ptgDe6c+Hcy8PHIkk340xqjpnw5vAMXQg0epVe
         sAf4KtMlQiU90VOC0jQg8FpJ3tAS9FfS+/E+g84+mPVoqjuk3idBMh1ij/at+XIY4dN/
         g1LqadNQdpFOsPeWQcLJBphikMDb2w6+nCdjtvvL1t72BlJyYbk7JTKEXssBVe5BmlJj
         C0FCkIgO895PljSkL7ELKH67zSNzBeDxynIcajMChCFXKzawtODk/UlUtEcUk5oF7eZA
         z68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGuG1asRy1Pd6i7LZD0Q+1ycYN3PhkFDWywCgQeZeaY=;
        b=hypF/rDXcdMADGWS/gKXBAvC/Pq4bT8m19CvKwp90WWwOgX/2zbpCKQY6FNtpDG4zI
         asJLJIgL4+mxiaHV822rH4tkvgA0HuPFHODx6FpxgjPBxlkF6uFCD4E5SfIrrAhWNqxR
         IE1CQJV6E76CNoLRmjo50+cqf/wZYvB8zZkzGRCOchH2Cy6FrZw09rE6mUWckPKekhpY
         DJa3JNrYPnzlbzs3oDcohYXCtUHlDrUEnHit+0iXXxKg/pWoJQMqpXBqLsS14Q/XPy1J
         VMJOQldM9apAwRF9zeIlTmYHc14OQL+dhs4uFBr0LQPTWHEwLn4nDI/MYZP6BsjJtDML
         0GpA==
X-Gm-Message-State: APjAAAVYBZdiA1G2t9D963TM0i4gqgVV0GsJ7rgbUz/EKBfGmK0xa6Lu
        oEk82qwYYTtbZinKmMF7+WDx9z7GwcxX7Dw8Xs2vFg==
X-Google-Smtp-Source: APXvYqydhmDxjTnxvFA+bkrPFtaf5CWiccBWdY55qCD8pTVEhAH/wNy6ubCJ6Wv9G70Sm8WS+siNyBaJx6EIINzy3lQ=
X-Received: by 2002:a63:541e:: with SMTP id i30mr20918922pgb.130.1572269911356;
 Mon, 28 Oct 2019 06:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f838060595f602a7@google.com> <s5hr22xau8f.wl-tiwai@suse.de>
In-Reply-To: <s5hr22xau8f.wl-tiwai@suse.de>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 28 Oct 2019 14:38:20 +0100
Message-ID: <CAAeHK+yUrW00w_qDZ9L71WVXyX-Y__cbohZkUhNWDnYoVfV69g@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in get_term_name
To:     Takashi Iwai <tiwai@suse.de>
Cc:     syzbot <syzbot+8f2612936028bfd28f28@syzkaller.appspotmail.com>,
        Allison Randal <allison@lohutok.net>,
        alsa-devel@alsa-project.org,
        =?UTF-8?B?5b2t6L6J?= <benquike@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alexander Potapenko <glider@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.com>, wang6495@umn.edu,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 2:13 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 28 Oct 2019 11:32:07 +0100,
> syzbot wrote:
> >
> > Uninit was stored to memory at:
> >  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:151 [inline]
> >  kmsan_internal_chain_origin+0xbd/0x180 mm/kmsan/kmsan.c:319
> >  __msan_chain_origin+0x6b/0xd0 mm/kmsan/kmsan_instr.c:179
> >  parse_term_proc_unit+0x73d/0x7e0 sound/usb/mixer.c:896
> >  __check_input_term+0x13ef/0x2360 sound/usb/mixer.c:989
>
> So this comes from the invalid descriptor for a processing unit, and
> it's very likely the same issue as already spotted -- the validator up
> to 5.3-rc4 had a bug that passed the invalid descriptor falsely.
> This should have been covered by 5.3-rc5, commit ba8bf0967a15 ("ALSA:
> usb-audio: Fix copy&paste error in the validator").

#syz dup: KASAN: slab-out-of-bounds Read in build_audio_procunit

Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513E3C43215
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5C12073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsR4nxLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfLDETV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 23:19:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43213 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfLDETU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 23:19:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so5112198oth.10;
        Tue, 03 Dec 2019 20:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oO5aKHWqKZXgtDSzybkME6BK6jEsYJ93MQcu7wW6Ois=;
        b=UsR4nxLGxkGDB8c1PVJMKEM9OO+Ridm9v4kB8Sovl3epF/ujjT7s3EPYaXWek871Ap
         m3baBWk2e58Ho1eagyO56sSNRY90MUm9QRdNb7WD2BEnkJzlGMbABMjkL+JibbwXTnUq
         NPgTfgku2xEMZjoRYeOqZNwmMvVkd8uwaj17GZjdo6j4QTNrImxHtCTbAKGVm0d69UC4
         WUAZGyyZRnKJyCEgTHWXvPfT1GFVhT52kkiakkMmO1TcdyicBbMQOYuHLzaZwVby+JV0
         Am+QLOtz5qR7KUVokXCwlMZr6z1f6XmDxtCxGDhsbLPZRzgm8kLQGO5p85cKTQX670YM
         bjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oO5aKHWqKZXgtDSzybkME6BK6jEsYJ93MQcu7wW6Ois=;
        b=S35s0moz7Tx0MPFoOaTA+CiE2FjzSZ5B1P6sBFg5U4JG1MlT9IyReI+uJVw4fvnnug
         LwJKROihtZ8jC5W7kGP7SNBtxFzH2X0IOhYDoS9vMjZ1Xx2zRq5EcETVhbpBpkKUeDTl
         ATEuOflVu9CZimisZllXje63xsDq61ngsGgVGlHlJRdFQ7NmKO6bl2OC9h/a9Vs9gL+8
         cQLbKbWjK/WBQVm/9RHEIdyC1N6gFzkN597ZEJHN9lid/Ri9J7n1l7X3vqjYnzSjYd18
         boU+VWI7PaVmWFUEhiaH6H8Z25l9LQedw7k/KtCD2ztVOxgGANuhg3DjCJ6syDGV4H/q
         Wz4A==
X-Gm-Message-State: APjAAAXpQ3JfsfrezT0CbX/RhO2TOQE5lplCsZOdwYp5fxPaFlMz2+5t
        nkcrRcZvNnW0nR4kyseE4X9dSxUMzef3UcgHFNg=
X-Google-Smtp-Source: APXvYqytyNA2QkmAJY7xC5kFRg0u6U/Fdz8XWksN3Nv4gba/r2jxdUps87kfcX5VKf3Oss1lFcZ3soNRgEF+xYh58lc=
X-Received: by 2002:a9d:64ce:: with SMTP id n14mr1025741otl.263.1575433159471;
 Tue, 03 Dec 2019 20:19:19 -0800 (PST)
MIME-Version: 1.0
References: <20190113021719.46457-1-samuel@sholland.org> <20190113021719.46457-2-samuel@sholland.org>
 <472c5450-1b60-6ac7-b242-805c2a2f3272@arm.com>
In-Reply-To: <472c5450-1b60-6ac7-b242-805c2a2f3272@arm.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Tue, 3 Dec 2019 20:18:53 -0800
Message-ID: <CA+E=qVfaBcUN5iB3kaK5gHyURpWt7ET6_js=sLiDg4PCDXXTYA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v3 1/2] arm64: arch_timer: Workaround
 for Allwinner A64 timer instability
To:     marc.zyngier@arm.com
Cc:     Samuel Holland <samuel@sholland.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 1:25 AM Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> Hi Samuel,

Hi Samuel,

> On 13/01/2019 02:17, Samuel Holland wrote:
> > The Allwinner A64 SoC is known[1] to have an unstable architectural
> > timer, which manifests itself most obviously in the time jumping forwar=
d
> > a multiple of 95 years[2][3]. This coincides with 2^56 cycles at a
> > timer frequency of 24 MHz, implying that the time went slightly backwar=
d
> > (and this was interpreted by the kernel as it jumping forward and
> > wrapping around past the epoch).
> >
> > Investigation revealed instability in the low bits of CNTVCT at the
> > point a high bit rolls over. This leads to power-of-two cycle forward
> > and backward jumps. (Testing shows that forward jumps are about twice a=
s
> > likely as backward jumps.) Since the counter value returns to normal
> > after an indeterminate read, each "jump" really consists of both a
> > forward and backward jump from the software perspective.
> >
> > Unless the kernel is trapping CNTVCT reads, a userspace program is able
> > to read the register in a loop faster than it changes. A test program
> > running on all 4 CPU cores that reported jumps larger than 100 ms was
> > run for 13.6 hours and reported the following:
> >
> >  Count | Event
> > -------+---------------------------
> >   9940 | jumped backward      699ms
> >    268 | jumped backward     1398ms
> >      1 | jumped backward     2097ms
> >  16020 | jumped forward       175ms
> >   6443 | jumped forward       699ms
> >   2976 | jumped forward      1398ms
> >      9 | jumped forward    356516ms
> >      9 | jumped forward    357215ms
> >      4 | jumped forward    714430ms
> >      1 | jumped forward   3578440ms
> >
> > This works out to a jump larger than 100 ms about every 5.5 seconds on
> > each CPU core.
> >
> > The largest jump (almost an hour!) was the following sequence of reads:
> >     0x0000007fffffffff =E2=86=92 0x00000093feffffff =E2=86=92 0x0000008=
000000000
> >
> > Note that the middle bits don't necessarily all read as all zeroes or
> > all ones during the anomalous behavior; however the low 10 bits checked
> > by the function in this patch have never been observed with any other
> > value.
> >
> > Also note that smaller jumps are much more common, with backward jumps
> > of 2048 (2^11) cycles observed over 400 times per second on each core.
> > (Of course, this is partially explained by lower bits rolling over more
> > frequently.) Any one of these could have caused the 95 year time skip.
> >
> > Similar anomalies were observed while reading CNTPCT (after patching th=
e
> > kernel to allow reads from userspace). However, the CNTPCT jumps are
> > much less frequent, and only small jumps were observed. The same progra=
m
> > as before (except now reading CNTPCT) observed after 72 hours:
> >
> >  Count | Event
> > -------+---------------------------
> >     17 | jumped backward      699ms
> >     52 | jumped forward       175ms
> >   2831 | jumped forward       699ms
> >      5 | jumped forward      1398ms
> >
> > Further investigation showed that the instability in CNTPCT/CNTVCT also
> > affected the respective timer's TVAL register. The following values wer=
e
> > observed immediately after writing CNVT_TVAL to 0x10000000:
> >
> >  CNTVCT             | CNTV_TVAL  | CNTV_CVAL          | CNTV_TVAL Error
> > --------------------+------------+--------------------+----------------=
-
> >  0x000000d4a2d8bfff | 0x10003fff | 0x000000d4b2d8bfff | +0x00004000
> >  0x000000d4a2d94000 | 0x0fffffff | 0x000000d4b2d97fff | -0x00004000
> >  0x000000d4a2d97fff | 0x10003fff | 0x000000d4b2d97fff | +0x00004000
> >  0x000000d4a2d9c000 | 0x0fffffff | 0x000000d4b2d9ffff | -0x00004000
> >
> > The pattern of errors in CNTV_TVAL seemed to depend on exactly which
> > value was written to it. For example, after writing 0x10101010:
> >
> >  CNTVCT             | CNTV_TVAL  | CNTV_CVAL          | CNTV_TVAL Error
> > --------------------+------------+--------------------+----------------=
-
> >  0x000001ac3effffff | 0x1110100f | 0x000001ac4f10100f | +0x1000000
> >  0x000001ac40000000 | 0x1010100f | 0x000001ac5110100f | -0x1000000
> >  0x000001ac58ffffff | 0x1110100f | 0x000001ac6910100f | +0x1000000
> >  0x000001ac66000000 | 0x1010100f | 0x000001ac7710100f | -0x1000000
> >  0x000001ac6affffff | 0x1110100f | 0x000001ac7b10100f | +0x1000000
> >  0x000001ac6e000000 | 0x1010100f | 0x000001ac7f10100f | -0x1000000
> >
> > I was also twice able to reproduce the issue covered by Allwinner's
> > workaround[4], that writing to TVAL sometimes fails, and both CVAL and
> > TVAL are left with entirely bogus values. One was the following values:
> >
> >  CNTVCT             | CNTV_TVAL  | CNTV_CVAL
> > --------------------+------------+-------------------------------------=
-
> >  0x000000d4a2d6014c | 0x8fbd5721 | 0x000000d132935fff (615s in the past=
)
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Because the CPU can read the CNTPCT/CNTVCT registers faster than they
> > change, performing two reads of the register and comparing the high bit=
s
> > (like other workarounds) is not a workable solution. And because the
> > timer can jump both forward and backward, no pair of reads can
> > distinguish a good value from a bad one. The only way to guarantee a
> > good value from consecutive reads would be to read _three_ times, and
> > take the middle value only if the three values are 1) each unique and
> > 2) increasing. This takes at minimum 3 counter cycles (125 ns), or more
> > if an anomaly is detected.
> >
> > However, since there is a distinct pattern to the bad values, we can
> > optimize the common case (1022/1024 of the time) to a single read by
> > simply ignoring values that match the error pattern. This still takes n=
o
> > more than 3 cycles in the worst case, and requires much less code. As a=
n
> > additional safety check, we still limit the loop iteration to the numbe=
r
> > of max-frequency (1.2 GHz) CPU cycles in three 24 MHz counter periods.
> >
> > For the TVAL registers, the simple solution is to not use them. Instead=
,
> > read or write the CVAL and calculate the TVAL value in software.
> >
> > Although the manufacturer is aware of at least part of the erratum[4],
> > there is no official name for it. For now, use the kernel-internal name
> > "UNKNOWN1".
> >
> > [1]: https://github.com/armbian/build/commit/a08cd6fe7ae9
> > [2]: https://forum.armbian.com/topic/3458-a64-datetime-clock-issue/
> > [3]: https://irclog.whitequark.org/linux-sunxi/2018-01-26
> > [4]: https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/dr=
ivers/clocksource/arm_arch_timer.c#L272
>
> nit: In general, I'm not overly keen on URLs in commit messages, as they
> may vanish without notice and the commit message becomes less useful. In
> the future, please keep those in the cover letter (though in this
> particular case, the commit message explains the issue pretty well, so
> no harm done once GitHub dies a horrible death... ;-).
>
> The fix itself looks pretty solid, and will hopefully make the
> "AllLoosers" HW more usable.

Unfortunately this patch doesn't completely eliminate the jumps. There
have been reports from users who still saw 95y jump even with the
patch applied.

Personally I've seen it once or twice on my Pine64-LTS.

Looks like we need bigger hammer. Does anyone have any idea what it could b=
e?

Regards,
Vasily


> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
>
> Daniel, please consider this for v5.1.
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

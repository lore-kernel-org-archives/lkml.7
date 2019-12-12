Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713D6C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC3021556
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="osM2qIGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbfLLUKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:10:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42066 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730703AbfLLUKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:10:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so3272316otd.9;
        Thu, 12 Dec 2019 12:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7qXkeZV74bje26NgCl5xWXQcNmUybdFUwUsZ8xV5JBg=;
        b=osM2qIGr3hGnVVczgOggDP8yZ4BLwi4bJkQh+zYOWI36YpgtY/j+xU9LCtmyq32DBd
         Mjj+23mFP8L9FoYlLmufBfmOpUomC9vzeHZhOTYaVZMVXfgww5OMb9Zy9INqH79IKoad
         /gGQVB82TujuEl87tkDn/MLsgvd5yiqExg2DcudusJa9+yXkl5Ctv0VpGy612OPSnW1Q
         QZyUEdPErjULdppAUQ81I9t97g81kQ4pUJP/wJrdnPGjO+hHvbRFUZiIIt6DQA2dWGeT
         ege3a93qQKLb/1GCRI1m1kxyBKmDUdrKmQk4Goby+4PYPaU3QJnYMqFySOBG8zcHiV72
         v2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7qXkeZV74bje26NgCl5xWXQcNmUybdFUwUsZ8xV5JBg=;
        b=R9rrhpWWKgmtnHSV/+GH/Qlx+glMdYgkrBulTxmPYmLTkykNrycuB5ZUQAmqUusDf4
         CqkXyyYfKIZ3Sq7qt5JMirS31MBIDwYA/OwjcCvg/c8AWXcaOlaRfYduDge/TFp+AWOC
         i4/aHFQ2sxtEM565Qz8vFGUgSvO285F3sw0/5KcbzKwsKh1ae/QyJyLyXnGKZXLPjdo/
         1kMpWA/cwzQ2PEQ2Y0mZiyWBMAKsHVJfGYU4yqzgqfYL5SRYqrrK4MGVhMepKYFvJTJX
         MNhHWu1CS6jsMaGl0x5VkN+5ncM4my2KjWjo/TdLTBSae0vrwNoUxjZu5fSnyxBA9huL
         AmFA==
X-Gm-Message-State: APjAAAXB2iwW5t3vzMKAF6xO+oCAGzStIhQs2v4I1gsm4ARO5Wl1r7He
        9VsZrN7HSK5E4IGVsC/Qhbd0Wr6SCvWAjv4qrHc=
X-Google-Smtp-Source: APXvYqyyXC4xCET3bH9d4JwztvKF8qJ5uMa+OdBlTIJYxnxVioR5wZQgPot30XdCsn1UDNUkV//KHNktBacycDlqK1U=
X-Received: by 2002:a05:6830:2087:: with SMTP id y7mr9659452otq.96.1576181405915;
 Thu, 12 Dec 2019 12:10:05 -0800 (PST)
MIME-Version: 1.0
References: <20191101143126.2549-1-linux.amoon@gmail.com> <7hfthtrvvv.fsf@baylibre.com>
 <c89791de-0a46-3ce2-b3e2-3640c364cd0f@baylibre.com> <CANAwSgQx3LjQe60TGgKyk6B5BD5y1caS2tA+O+GFES7=qCFeKg@mail.gmail.com>
 <7hfthsqcap.fsf@baylibre.com> <CAFBinCBfgxXhPKpBLdoq9AimrpaneYFgzgJoDyC-2xhbHmihpA@mail.gmail.com>
 <7hpngvontu.fsf@baylibre.com> <4e1339b4-c751-3edc-3a2e-36931ad1c503@baylibre.com>
In-Reply-To: <4e1339b4-c751-3edc-3a2e-36931ad1c503@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 12 Dec 2019 21:09:55 +0100
Message-ID: <CAFBinCCgKcwXSLxS_CRvz9JZvQo8PcUGm=egBbabVZSrkSc30Q@mail.gmail.com>
Subject: Re: [RFC-next 0/1] Odroid C2: Enable DVFS for cpu
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Dec 11, 2019 at 9:49 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 10/12/2019 22:47, Kevin Hilman wrote:
> > Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
> >
> >> On Tue, Dec 10, 2019 at 7:13 PM Kevin Hilman <khilman@baylibre.com> wrote:
> >>>
> >>> Anand Moon <linux.amoon@gmail.com> writes:
> >>>
> >>>> Hi Neil / Kevin,
> >>>>
> >>>> On Tue, 10 Dec 2019 at 14:13, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>>>>
> >>>>> On 09/12/2019 23:12, Kevin Hilman wrote:
> >>>>>> Anand Moon <linux.amoon@gmail.com> writes:
> >>>>>>
> >>>>>>> Some how this patch got lost, so resend this again.
> >>>>>>>
> >>>>>>> [0] https://patchwork.kernel.org/patch/11136545/
> >>>>>>>
> >>>>>>> This patch enable DVFS on GXBB Odroid C2.
> >>>>>>>
> >>>>>>> DVFS has been tested by running the arm64 cpuburn
> >>>>>>> [1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
> >>>>>>> PM-QA testing
> >>>>>>> [2] https://git.linaro.org/power/pm-qa.git [cpufreq testcase]
> >>>>>>>
> >>>>>>> Tested on latest U-Boot 2019.07-1 (Aug 01 2019 - 23:58:01 +0000) Arch Linux ARM
> >>>>>>
> >>>>>> Have you tested with the Harkernel u-boot?
> >>>>>>
> >>>>>> Last I remember, enabling CPUfreq will cause system hangs with the
> >>>>>> Hardkernel u-boot because of improperly enabled frequencies, so I'm not
> >>>>>> terribly inclined to merge this patch.
> >>>>
> >>>> HK u-boot have many issue with loading the kernel, with load address
> >>>> *it's really hard to build the kernel for HK u-boot*,
> >>>> to get the configuration correctly.
> >>>>
> >>>> Well I have tested with mainline u-boot with latest ATF .
> >>>> I would prefer mainline u-boot for all the Amlogic SBC, since
> >>>> they sync with latest driver changes.
> >>>
> >>> Yes, we would all prefer mainline u-boot, but the mainline kernel needs
> >>> to support the vendor u-boot that is shipping with the boards.  So
> >>> until Hardkernel (and other vendors) switch to mainline u-boot we do not
> >>> want to have upstream kernel defaults that will not boot with the vendor
> >>> u-boot.
> >>>
> >>> We can always support these features, but they just cannot be enabled
> >>> by default.
> >> (I don't have an Odroid-C2 but I'm curious)
> >> should Anand submit a patch to mainline u-boot instead?
> >
> > It would be in addition to $SUBJECT patch, not instead, I think.
> >
> >> the &scpi_clocks node could be enabled at runtime by mainline u-boot
> >
> > That would work, but I don't know about u-boot maintainers opinions on
> > this kind of thing, so let's see what Neil thinks.
>
> U-Boot doesn't anything to do with SCPI, SCPI discusses directly with the SCP
> processor, and the CPU clock is set to 1,56GHz by the BL2 boot stage before
> U-boot starts.
>
> The only viable solution I see now is to find if we could add a DT OPP table
> only for Odroid-C2 dts to bypass the SCPI OPP table.
my understanding is that mainline u-boot (with whatever SCP firmware
it uses) provides the *correct* OPP table
in this case it would be "safe" to have SCPI enabled with mainline u-boot
@Anand: please correct me if I misunderstood you

my idea to "enable SCPI with mainline u-boot" is to have u-boot update
the "status" property of the scpi_clocks node.
u-boot does something similar with the mac-address property of the
Ethernet controller for example.
as result of this users of mainline u-boot would have working CPU
DVFS, while users of the old vendor u-boot would run at fixed 1.54GHz.


Martin

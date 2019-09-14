Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C94C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 17:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE572067D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 17:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oR/DGMfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbfINRk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 13:40:56 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32884 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfINRkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 13:40:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id e18so977020oii.0;
        Sat, 14 Sep 2019 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScwrZFTGOc+kbhhZsRu5GL1IOvADxSoY4roa9r4rvrc=;
        b=oR/DGMfb/9sZrS1uWjRRtNMdrY5WzzoMndCtZaKV+gw+KnCyNqnAKD24aJKKHJdhxu
         i7amzSzK25ME7g67a28AVFajVTK1cxb+fmXDMU3GS565nM7NXjVzmCa0GD3MOJ6wO5Pp
         sgODIbPNcyMnunPtbLm0F3kOFWFeMMfYJp/Jlt/maGebgXr3vcTwhEgPwASNRV+50Pjg
         N620uvQjpgRfC54Yg71xZ7CQbDchDgFgsYw186toIk3YCFIMqHkiTH4G8cDjv1uhtv6k
         6CgYOUzRHIF14PfBznVGZmQpHsEl3KPgCzFYkK98WoRPBqoSUhB8ZvFYFQK2WLEceNUq
         m55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScwrZFTGOc+kbhhZsRu5GL1IOvADxSoY4roa9r4rvrc=;
        b=YpbNn5SYuRII7pb2GVHhMbl5jBkY/CH3zzMb32c/RXAzIv4Q47QR+2Rif3GUNdBoP1
         MUKHdMknyz8/qQgE9Dk0ZIXelpqEDjoR2n4cNEz2IZLT612B5PRp73cp2jdelFWGolvU
         RAffO0MjI5NsK8UNAzCrx9MEyUZGEZs1/GHWAZZVXxdwCA2z6ZohxS3aA1NzpD8E03nd
         ujY91JMT8WR+EdHgB7E2FaKzfO0gCKSsmXFQmDqan/ckvCqg8wb8pTt7YiX9Ln7PvH/n
         5F7vLVLi+o+5Ps3gs7h+0zRuPqKftFV3hQ2Bkzwg8AgQNolnXStOnL/OnBHRKmj4aJMB
         tIyw==
X-Gm-Message-State: APjAAAWDXpKySxZuloJsmJT3hJnxM4V6AUyn803H2q2O8FORr6pWVpxd
        IkDc0JPfGxk34t45S0D5d1AwWsTR8xqbpJw4yHM=
X-Google-Smtp-Source: APXvYqxzDSV60TGVXBUNUlUYl4UV7zv7qNNLwQJ0PfQSVLqrKQObbcGram3Yy+w0QN7EAUgIusf4gu4nw3EU9eIuIxE=
X-Received: by 2002:aca:4d08:: with SMTP id a8mr8328954oib.39.1568482854580;
 Sat, 14 Sep 2019 10:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <1567780354-59472-1-git-send-email-christianshewitt@gmail.com> <1567780354-59472-4-git-send-email-christianshewitt@gmail.com>
In-Reply-To: <1567780354-59472-4-git-send-email-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 14 Sep 2019 19:40:42 +0200
Message-ID: <CAFBinCANaKMHRuwaFwubZcDjZaGYcLcVuHjJsakR0uJkmZxRMw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 3/3] arm64: dts: meson-g12b-ugoos-am6: add
 initial device-tree
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleg Ivanov <balbes-150@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

my nit-picks below

On Fri, Sep 6, 2019 at 4:34 PM Christian Hewitt
<christianshewitt@gmail.com> wrote:
[...]
> +       spdif_dit: audio-codec-1 {
> +               #sound-dai-cells = <0>;
> +               compatible = "linux,spdif-dit";
> +               status = "okay";
> +               sound-name-prefix = "DIT";
> +       };
please move it below sdio_pwrseq (or at least somewhere below the memory node)

[...]
> +       vcc_3v3: regulator-vcc_3v3 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "VCC_3V3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               vin-supply = <&vddao_3v3>;
> +               regulator-always-on;
> +               /* FIXME: actually controlled by VDDCPU_B_EN */
can we add the enable GPIO here now that we know how to describe the
VDDCPU_B regulator?

[...]
> +       usb1_pow: regulator-usb1_pow {
for consistency with the regulators above: regulator-usb1-pow

[...]
> +       usb_pwr_en: regulator-usb_pwr_en {
for consistency with the regulators above: regulator-usb-pwr-en

[...]
> +       vddao_1v8: regulator-vddao_1v8 {
for consistency with the regulators above: regulator-vddao-1v8

[...
> +       vddao_3v3: regulator-vddao_3v3 {
for consistency with the regulators above: regulator-vddao-3v3

[...]
> +&cpu0 {
> +       cpu-supply = <&vddcpu_b>;
> +       operating-points-v2 = <&cpu_opp_table_0>;
> +       clocks = <&clkc CLKID_CPU_CLK>;
> +       clock-latency = <50000>;
> +};
> +
> +&cpu1 {
> +       cpu-supply = <&vddcpu_b>;
> +       operating-points-v2 = <&cpu_opp_table_0>;
> +       clocks = <&clkc CLKID_CPU_CLK>;
> +       clock-latency = <50000>;
> +};
> +
> +&cpu100 {
> +       cpu-supply = <&vddcpu_a>;
> +       operating-points-v2 = <&cpub_opp_table_1>;
> +       clocks = <&clkc CLKID_CPUB_CLK>;
> +       clock-latency = <50000>;
> +};
> +
> +&cpu101 {
> +       cpu-supply = <&vddcpu_a>;
> +       operating-points-v2 = <&cpub_opp_table_1>;
> +       clocks = <&clkc CLKID_CPUB_CLK>;
> +       clock-latency = <50000>;
> +};
> +
> +&cpu102 {
> +       cpu-supply = <&vddcpu_a>;
> +       operating-points-v2 = <&cpub_opp_table_1>;
> +       clocks = <&clkc CLKID_CPUB_CLK>;
> +       clock-latency = <50000>;
> +};
> +
> +&cpu103 {
> +       cpu-supply = <&vddcpu_a>;
> +       operating-points-v2 = <&cpub_opp_table_1>;
> +       clocks = <&clkc CLKID_CPUB_CLK>;
> +       clock-latency = <50000>;
> +};
(not limited to this patch: there's a lot of redundancy with the CPU
nodes across the G12B .dts)

[...]
> +&sd_emmc_a {
all nodes starting here should use alphabetical sorting


Martin

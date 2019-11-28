Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72118C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35523208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 00:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjvgZSxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfK1AA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 19:00:57 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:35159 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfK1AA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 19:00:56 -0500
Received: by mail-qv1-f68.google.com with SMTP id y18so9667623qve.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 16:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:message-id;
        bh=7NGFDtAUlGsxjN/dQKdrDmkDxdsAGrMP7xzXyoFEI2g=;
        b=UjvgZSxijW9h73Mx0HnA3uKXnaQ/hxO3IIoZlyH5nWlVQ92tJ1kynC+Ef5DkEydoIY
         a8qI5CqNLB3eNmvGrsb35dS2u2BqdAu2enG0vTcujj20rXo2g4+OGkyfps+HdxIiB5Vg
         nYqL0PTJIAK6rcovKmvlh9Y7ZXvKdBQR0krjostma24z71WDWNzsr74bXyoCwh+LTWeX
         YgLCCCfaLihHGNBlRFnly76AXSLJ41fs6N2YXxtBpEbFYjVS3TvsDmrCBpkQ9Q3ND2gS
         Oh1DwYXfpJQ9CP2pKNnfIHGm2U5oQtGckiNLgwnAWecBByCvEP9WGe9VcgZdciRBZNQB
         SPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:message-id;
        bh=7NGFDtAUlGsxjN/dQKdrDmkDxdsAGrMP7xzXyoFEI2g=;
        b=PsKFT4luFnLSS77tLYrBiRPDqvfDXCNh4Jg8z9/NbKYyprxhVmE0Qv2d2MBW3oOcVz
         HXVyyNEiHJ9/i7xADxdWJvlmIszbPKmPRxMU0Hjd0HBf8xjIYvRwBN4wP83PPYxkCPcq
         f+piWLaLBJzOnVzA/+YVuTHq1/U/QAEySLUsx57d/aU45yT9jIboB0nw9Io5v1R3EL0V
         yC7MaNdHhtO0q/x2+ezRqZa+bk/+527oOWQ4u3TTz4PWNXU1rIUDVOk303JVfW94bbEG
         bkZqtUh43bPJb2Wtyh1ITYN7AZCpw8kZ1OQsxIm1DmWMQT9i+kXhos7uQHZ/+pWBUwIB
         861w==
X-Gm-Message-State: APjAAAWMgVvkIEjdi2fPrivEllojB6XK9hEly7ALgq5Qm3Z54rMXhNNM
        w/WRAy+lE6IRDIVmKobETxw=
X-Google-Smtp-Source: APXvYqwXZie5I+jqFzS57E05EtNky0MC0a0s7QpUU4GNXxBtpraw165/Gv5Ip7Tn/S9S7kL3Zex2BQ==
X-Received: by 2002:a0c:b0fa:: with SMTP id p55mr8087516qvc.239.1574899255800;
        Wed, 27 Nov 2019 16:00:55 -0800 (PST)
Received: from [192.168.86.249] ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id p1sm7554477qkc.25.2019.11.27.16.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 16:00:55 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Date:   Wed, 27 Nov 2019 21:01:30 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20191127232657.GL84886@tassilo.jf.intel.com>
References: <20191121001522.180827-1-andi@firstfloor.org> <20191127151657.GE22719@kernel.org> <20191127154305.GJ22719@kernel.org> <20191127232657.GL84886@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Optimize perf stat for large number of events/cpus
To:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <033E8FCB-2430-48E0-8631-0F0236D5E904@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 27, 2019 8:26:57 PM GMT-03:00, Andi Kleen <ak@linux=2Eintel=2Ec=
om> wrote:
>On Wed, Nov 27, 2019 at 12:43:05PM -0300, Arnaldo Carvalho de Melo
>wrote:
>> So, have you tried running 'perf test' after each cset is applied and
>> built?
>
>I ran it at the end, but there are quite a few fails out of the box,
>so I missed that one thanks=2E
>
>This patch fixes it=2E Let me know if I should submit it in a more
>formal way=2E
>
>---
>
>Fix event times test case
>
>Reported-by: Arnaldo
>Signed-off-by: Andi Kleen <ak@linux=2Eintel=2Ecom>
>
>diff --git a/tools/perf/lib/evsel=2Ec b/tools/perf/lib/evsel=2Ec
>index 4c6485fc31b9=2E=2E4dc06289f4c7 100644
>--- a/tools/perf/lib/evsel=2Ec
>+++ b/tools/perf/lib/evsel=2Ec
>@@ -224,7 +224,7 @@ int perf_evsel__enable(struct perf_evsel *evsel)
> 	int i;
> 	int err =3D 0;
>=20
>-	for (i =3D 0; i < evsel->cpus->nr && !err; i++)
>+	for (i =3D 0; i < xyarray__max_x(evsel->fd) && !err; i++)
> 		err =3D perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, NULL, i);
> 	return err;
> }
>@@ -239,7 +239,7 @@ int perf_evsel__disable(struct perf_evsel *evsel)
> 	int i;
> 	int err =3D 0;
>=20
>-	for (i =3D 0; i < evsel->cpus->nr && !err; i++)
>+	for (i =3D 0; i < xyarray__max_x(evsel->fd) && !err; i++)
> 		err =3D perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, NULL, i);
> 	return err;
> }
>diff --git a/tools/perf/util/evsel=2Ec b/tools/perf/util/evsel=2Ec
>index 59b9b4f3fe34=2E=2E0844e3e29fb0 100644
>--- a/tools/perf/util/evsel=2Ec
>+++ b/tools/perf/util/evsel=2Ec
>@@ -1853,6 +1853,10 @@ int perf_evsel__open_per_cpu(struct evsel
>*evsel,
> 			     struct perf_cpu_map *cpus,
> 			     int cpu)
> {
>+	if (cpu =3D=3D -1)
>+		return evsel__open_cpu(evsel, cpus, NULL, 0,
>+					cpus ? cpus->nr : 1);
>+
> 	return evsel__open_cpu(evsel, cpus, NULL, cpu, cpu + 1);
> }
>=20

Just save me some time by saying to which cset in v8 I should squash this =
into, so that we keep the whole shebang bisectable,

Thanks,

- Arnaldo

Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B055C04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 00:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5E721883
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 00:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVyVw5po"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfERAFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 20:05:42 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53680 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfERAFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 20:05:42 -0400
Received: by mail-it1-f193.google.com with SMTP id m141so14610981ita.3;
        Fri, 17 May 2019 17:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a7C3dDuMzG9dHiTnNVWPV79gGpjU//Ll/DxT8px+pnA=;
        b=CVyVw5podqSpC5UGS+ZuDip7eZbEJsXzX5VFUZwanx1U0toRMkJnW3butmBLZQY9PS
         C2ucdTjm40bKAPWLQKIm1QHIW2OZwTATdIX2W7RyZ6qwXmEU12TPRwcIA8rIGrEA8ozV
         WpYrpWX18EtaXAVcolUj8CHOfnPvtAd+YJaS0/zd+VhWWS/sUqQinu5Fr3LcMIpBhOts
         hQ6ZQnvpmZmZML5TlzCYpKJU8QzrmEQKlQ7apx9yh6ncuua//ixyuEAmWJtNZPb1QXhJ
         zAP+dr+X1iAeedRZ5dI2Uat1j1lXAxvnRlfeW1qvhvowaM/wUznImexj8fdBqFkNnAtS
         Je2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a7C3dDuMzG9dHiTnNVWPV79gGpjU//Ll/DxT8px+pnA=;
        b=UMYnfzh+D4zOVmjrqJC0sZ2BSE7m4GR4W5mk3RGgJTgkB8zV205ypMrgaR6Dy/Sjq6
         MY9jZ5t9JevipvU4aa+XcvS09IgRrs/WBMxKwcoPu2r688B1ys8H2VExyvOeY85EHWk/
         UtUwg4VJYmn0m5vidG2PvVSH2CakZxeYbW3YcvyVsBKBmGdC949YuGtmoYo8JyYkioXa
         SbTTCQTthdj+cXO6ijvllq/QG3wO9wY1H3NQ8BE10Xt0uplOo754IecSRNuoiwQvV6Or
         NkK6pZjGA1bo9ABFW3A2OXto8tWW6ndK2C0c3vd/+ZDvhL68ZH3ulmfvkeBt4o21jPMC
         FJCg==
X-Gm-Message-State: APjAAAWTDcpEhf6tqAQOoPeEFo48VI45w0yi1Vn38dfE04FGa6k+ua3f
        DQhmBzguzjMHCV98rlHWor4=
X-Google-Smtp-Source: APXvYqynYhiMRG2RP3SVmO493+tsMr68p2mZGv/8isY4LI0ixkxiunudS0yasg6Q4VxiyV87VJawxg==
X-Received: by 2002:a24:9c47:: with SMTP id b68mr19781273ite.169.1558137940994;
        Fri, 17 May 2019 17:05:40 -0700 (PDT)
Received: from ?IPv6:2607:fea8:7a60:20d:68be:67af:76aa:290f? ([2607:fea8:7a60:20d:68be:67af:76aa:290f])
        by smtp.gmail.com with ESMTPSA id 74sm1095659itk.3.2019.05.17.17.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 17:05:40 -0700 (PDT)
From:   Donald Yandt <donald.yandt@gmail.com>
X-Google-Original-From: Donald Yandt <Donald.Yandt@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 20/73] perf machine: Null-terminate version char array upon fgets(/proc/version) error
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190517193611.4974-21-acme@kernel.org>
Date:   Fri, 17 May 2019 20:05:39 -0400
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Avi Kivity <avi@scylladb.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yanmin Zhang <yanmin_zhang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2D532F76-A57F-4CC4-BAA5-B466AFC0305D@gmail.com>
References: <20190517193611.4974-1-acme@kernel.org> <20190517193611.4974-21-acme@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Arnaldo for signing my patch.

     I think we should use version 4 of my patch and return NULL instead of n=
ull-terminating for efficiency.

Thanks,

Donald

> On May 17, 2019, at 3:35 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wr=
ote:
>=20
> From: Donald Yandt <donald.yandt@gmail.com>
>=20
> If fgets() fails due to any other error besides end-of-file, the version
> char array may not even be null-terminated.
>=20
> Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Avi Kivity <avi@scylladb.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Yanmin Zhang <yanmin_zhang@linux.intel.com>
> Fixes: a1645ce12adb ("perf: 'perf kvm' tool for monitoring guest performan=
ce from host")
> Link: http://lkml.kernel.org/r/20190514110100.22019-1-donald.yandt@gmail.c=
om
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
> tools/perf/util/machine.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 3c520baa198c..28a9541c4835 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1234,8 +1234,9 @@ static char *get_kernel_version(const char *root_dir=
)
>    if (!file)
>        return NULL;
>=20
> -    version[0] =3D '\0';
>    tmp =3D fgets(version, sizeof(version), file);
> +    if (!tmp)
> +        *version =3D '\0';
>    fclose(file);
>=20
>    name =3D strstr(version, prefix);
> --=20
> 2.20.1
>=20

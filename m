Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDFBCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B2220679
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cDDUvT7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbfJVIj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:39:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42219 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388366AbfJVIj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:39:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id f14so9497186pgi.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eApqYsG4e2cicMJq62zYg3NteuGKFbsXj+rZHKlYrI4=;
        b=cDDUvT7tE6kS1y83Xq++77H6H+Yisw1zBg5XQKZM01Ku2NMUOCvt+fjK9vnwStNlMd
         G1XP7moU287HDuI+90wzDg4KmHiMAREfcyjZgBDWnWhXGjZIXyxGj9Hlq2/rlvv/T7Vr
         QcwefftZNu9druK8hY710/5qE2kykFpQj1gXoPUCbNKf+yt14RoqzUnfUzDVZLmV9oSF
         0qYRgRJk3HtZycxlHl/UQXcjaZ7nNc1QQ1C708JwIPoSi+cVt7swoXR6fClCxm4HiBS4
         jj3nUyN+pUpT58Uk6c+SbtgRwXF0w2mr7msDr6HQaqaNxVzWxfd+l6C7PoK1zEe3odxK
         TO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eApqYsG4e2cicMJq62zYg3NteuGKFbsXj+rZHKlYrI4=;
        b=WIYoPyfBUO+Ledf+kjBAdDxM548xcrUrpZIiD3t62TRreYCRFZuWN81q8BmNJ7EOJ3
         y9s3BQ1hPG2qMM4g9L4r8v9xAgNq7CFRsiCO2+rkAE+zouE9L8uT5dpka7I0WvHgpgIy
         btKuehpGH0F7+xV+71cEyv++prXEmsuoCpLI3lt6+ryL65K/iFZwQifSbGQZoAw+3ARh
         hvJI2aBPrVd4jamc+sPnSPfHzGdp32FkERihxxftBeBPjg58LHsXFpxwxEjYBEgXPl0W
         /iKN8MOf2MyPn5QVYzuR/g/7YQg/iwrHjyaGdTBlG+XNLoOP6YI/MQ/Ig4kQ/IARe6cv
         6cKA==
X-Gm-Message-State: APjAAAV92agfb5ixe4Wv+TfQUU7xMjKVERaHOhc3wth2YsmyOAZPBDRY
        WmP50H+gHa0DST9whj5KGhdJGH2hGv8=
X-Google-Smtp-Source: APXvYqzoU91PMefRaVNwx7NkTM3WdM9pc2FdfwqZ56vV/RMHqHndA6hwGJsvhbRBkt0v+CwbGGBDLg==
X-Received: by 2002:a17:90a:c406:: with SMTP id i6mr3159050pjt.98.1571733566156;
        Tue, 22 Oct 2019 01:39:26 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id m19sm15343255pjl.28.2019.10.22.01.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 01:39:25 -0700 (PDT)
Date:   Tue, 22 Oct 2019 14:09:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     rafael.j.wysocki@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2] cpufreq: imx-cpufreq-dt: Correct i.MX8MN's default
 speed grade value
Message-ID: <20191022083923.pjqfokyoegispumw@vireshk-i7>
References: <1571733199-17406-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571733199-17406-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-19, 16:33, Anson Huang wrote:
> i.MX8MN has different speed grade definition compared to
> i.MX8MQ/i.MX8MM, when fuses are NOT written, the default
> speed_grade should be set to minimum available OPP defined
> in DT which is 1.2GHz, the corresponding speed_grade value
> should be 0xb.
> 
> Fixes: 5b8010ba70d5 ("cpufreq: imx-cpufreq-dt: Add i.MX8MN support")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- Improve the coding style by removing the tab;
> ---
>  drivers/cpufreq/imx-cpufreq-dt.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Applied. Thanks.

-- 
viresh

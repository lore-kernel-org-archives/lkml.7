Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DD8C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 20:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684E52245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 20:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kLQzpX2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfLFUpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 15:45:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41949 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfLFUpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 15:45:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so6234197lfp.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 12:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMYyDKhp6K7/5SuIEY9a+3PPHyckatVY1BJEQOFbYPw=;
        b=kLQzpX2iLT3Cw3LYn9w2xUhbQcZ1mnSOxrIeil8QWxuKB6jMDdBwqMcFQCjopElDvB
         9xVPY7OFh1i2ZL3ZJ1/IwfRSv+r6pliXLzcDbGK1wuAftk4uOBp0N6z4sVbWHKY7TjUM
         FDR3SKEII8ZT9AUEOqqRtcygJcuT9RKG0JZMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMYyDKhp6K7/5SuIEY9a+3PPHyckatVY1BJEQOFbYPw=;
        b=ETYxMbK7QuN+8G1nflHIJnGVARmZt02IakGcIDiG+W8O6+5K+iBJMphzRBCCUfe48b
         XH2IKAKaTmkk8OtdrEyPgBTutqbQkVQhB9iyG9nv6ZGWtgq3ucyOWnwu7Z2w1J7fgTOc
         HYY7XxKjaS0qgkL5HIu1Rgs69VkMC5UPb+S9exvqz6gyskfyL6EE7q4YbZ+n6W/5JayD
         pTMSu1llx/lz5r+UkN8ZkZCbgv61q+0BsfHwJVvwNF5qnFvCAgmLBZnI+a7Xy4a6RmYc
         CekSX86awJABgpgvOaStXk7tjjr7ZArJ2iYnuVmTf/vIkrrdQ8F0BlODTiSMtIx/vgjL
         YFww==
X-Gm-Message-State: APjAAAUTYuxIu6kvzhq+6gU7l41C3NE1jfHngepbuif4tMFX/vETdgAO
        +ZFWIGUjgk+DTewz8aRizNDIrmij2es=
X-Google-Smtp-Source: APXvYqye6n4tFMLXBQIdGF8vJV7zFo/iWe83UQhHwW8gbtB70iTahsiJL5UV0u7eZO631tvy3cQTbw==
X-Received: by 2002:a19:dc1e:: with SMTP id t30mr4837918lfg.34.1575665121992;
        Fri, 06 Dec 2019 12:45:21 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id d11sm7028129lfj.3.2019.12.06.12.45.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 12:45:21 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 15so6269262lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 12:45:21 -0800 (PST)
X-Received: by 2002:a19:ec14:: with SMTP id b20mr5175962lfa.63.1575665120607;
 Fri, 06 Dec 2019 12:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20191128134839.27606-1-georgi.djakov@linaro.org> <20191128134839.27606-2-georgi.djakov@linaro.org>
In-Reply-To: <20191128134839.27606-2-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 6 Dec 2019 12:44:44 -0800
X-Gmail-Original-Message-ID: <CAE=gft7WHWohbRLk-ungR54p_LUQz5TLeWsT1PtMVRza9M5H7w@mail.gmail.com>
Message-ID: <CAE=gft7WHWohbRLk-ungR54p_LUQz5TLeWsT1PtMVRza9M5H7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] interconnect: qcom: Use the standard aggregate function
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Dai <daidavid1@codeaurora.org>, masneyb@onstation.org,
        Sibi Sankar <sibis@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 5:48 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Now we have a common function for standard aggregation, so let's use it,
> instead of duplicating the code.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Evan Green <evgreen@chromium.org>

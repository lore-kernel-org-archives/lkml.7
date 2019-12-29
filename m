Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753C6C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 03:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3682176D
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 03:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QD9ypE87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfL2Dfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 22:35:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46695 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfL2Dfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 22:35:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so16425265pgb.13
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 19:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mPy3u4+QpRgdQYQ9Mp1NkaSkxalaThVlLa9KXxTz7Ew=;
        b=QD9ypE87A8v3ue0tIqTrH58ucVhmQHzMSX98LP8WrAkrOFprag+vQmQtsvovWYRHOa
         Z46L9sDfdQTq9Pwwa7DJ+uLxTPQEhohIvBrVoXuJ/xHhx4OEZD/9qea6X3QcIq2Q8rEo
         1UGBgmYBrsXiO7d+Q14Zuyyt13FRsi31CxCSWdm+0hSTz6zBA0btMNBSgQmMjbx1KRCZ
         +gYKUqM4QPVamvcNsTl5Ojm7IIMe8iw5e4DlvfGqbeXQkomZD1/v7+McOUelPf3B9OGd
         qEVL4nWrf+kyMu9wc9W4nx6w3/2w3gUUz/HiYo5ndU+Wmw2nNS6qVAlPoDVqBfpeXwVQ
         kdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mPy3u4+QpRgdQYQ9Mp1NkaSkxalaThVlLa9KXxTz7Ew=;
        b=pgMsSCePvUJShr852FOWghC8oMqlRLdaQnZMdYOq433YinmoS3EWO1kVXcVQEgx6os
         QOHCf/m7vQe20/9qwFHD4pPl8EyFF9U6iRwVln8GrYZXYQbWU8yD/e8dI/SQrNd2jXKZ
         JKjVSBAgv4aC5pKqMvzLuWCTA4T7PSY8UQgI5AjQgrcP6Fcl0TLepyyiW0pCUoLeibP/
         280gUEw+Ziyg/KfTKJY9mi6gh7qKPfA+TNFt8VWR/E75eDEi65dN0F2W8eR2lNAUPvTC
         BEmCQOBM3uoC2zXLAAYMnD1kwM/nRjYab6V/z46gZHHQIMStXiwgYxykm8SQdtVbhWA7
         YvVw==
X-Gm-Message-State: APjAAAU7sud+/Cxiw4vrmJnigvloQO7PUS3jWFiBZvCqyq8SAEGF9NKK
        vGmymSrutfLv8hPSXNwGENkUmA==
X-Google-Smtp-Source: APXvYqw3kcXlDAF9TLI0e6b0J3kH+Y2RIgxToCoMfP0JnE5f7DAMHXdqG6gnSuPT9MTpjghI10BToQ==
X-Received: by 2002:a65:5788:: with SMTP id b8mr63501355pgr.324.1577590533167;
        Sat, 28 Dec 2019 19:35:33 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d22sm44458904pfo.187.2019.12.28.19.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 19:35:32 -0800 (PST)
Date:   Sat, 28 Dec 2019 19:35:30 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sricharan R <sricharan@codeaurora.org>
Cc:     agross@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        sivaprak@codeaurora.org
Subject: Re: [PATCH V2 2/7] pinctrl: qcom: Add ipq6018 pinctrl driver
Message-ID: <20191229033530.GN3755841@builder>
References: <1576752109-24497-1-git-send-email-sricharan@codeaurora.org>
 <1576752109-24497-3-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576752109-24497-3-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19 Dec 02:41 PST 2019, Sricharan R wrote:
> diff --git a/drivers/pinctrl/qcom/pinctrl-ipq6018.c b/drivers/pinctrl/qcom/pinctrl-ipq6018.c
[..]
> +static const struct msm_function ipq6018_functions[] = {
[..]
> +	FUNCTION(qpic_pad),
> +	FUNCTION(qpic_pad0),
> +	FUNCTION(qpic_pad1),
> +	FUNCTION(qpic_pad2),
> +	FUNCTION(qpic_pad3),
> +	FUNCTION(qpic_pad4),
> +	FUNCTION(qpic_pad5),
> +	FUNCTION(qpic_pad6),
> +	FUNCTION(qpic_pad7),
> +	FUNCTION(qpic_pad8),

Shouldn't the qpic_padN entries be removed now? (Please double check the
rest as well)

[..]
> +
> +static const struct msm_pingroup ipq6018_groups[] = {
> +	PINGROUP(0, qpic_pad, wci20, qdss_traceclk_b, _, burn0, _, _, _, _),
> +	PINGROUP(1, qpic_pad, mac12, qdss_tracectl_b, _, burn1, _, _, _, _),
> +	PINGROUP(2, qpic_pad, wci20, qdss_tracedata_b, _, _, _, _, _, _),
> +	PINGROUP(3, qpic_pad, mac01, qdss_tracedata_b, _, _, _, _, _, _),
> +	PINGROUP(4, qpic_pad, mac01, qdss_tracedata_b, _, _, _, _, _, _),
> +	PINGROUP(5, qpic_pad, mac21, qdss_tracedata_b, _, _, _, _, _, _),
> +	PINGROUP(6, qpic_pad, mac21, qdss_tracedata_b, _, _, _, _, _, _),
> +	PINGROUP(7, qpic_pad, qdss_tracedata_b, _, _, _, _, _, _, _),
> +	PINGROUP(8, qpic_pad, qdss_tracedata_b, _, _, _, _, _, _, _),
> +	PINGROUP(9, qpic_pad, atest_char, cxc0, mac13, dbg_out, qdss_tracedata_b, _, _, _),
> +	PINGROUP(10, qpic_pad, qdss_tracedata_b, _, _, _, _, _, _, _),
> +	PINGROUP(11, qpic_pad, wci22, mac12, qdss_tracedata_b, _, _, _, _, _),
> +	PINGROUP(12, qpic_pad, qdss_tracedata_b, _, _, _, _, _, _, _),
> +	PINGROUP(13, qpic_pad, qdss_tracedata_b, _, _, _, _, _, _, _),
> +	PINGROUP(14, qpic_pad, qdss_tracedata_b, _, _, _, _, _, _, _),
> +	PINGROUP(15, qpic_pad, qdss_tracedata_b, _, _, _, _, _, _, _),
> +	PINGROUP(16, qpic_pad, cxc0, mac13, qdss_tracedata_b, _, _, _, _, _),
> +	PINGROUP(17, qpic_pad, qdss_tracedata_b, wci22, _, _, _, _, _, _),

Regards,
Bjorn

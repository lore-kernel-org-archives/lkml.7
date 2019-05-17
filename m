Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789BCC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C7320833
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lGozGAVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfEQKZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:25:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45092 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbfEQKZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:25:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so6497306wrq.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 03:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C0Cpfr3qIzMoBN9F7dCRlBuwVDMbdHyBOSFIiovRDi4=;
        b=lGozGAVT6NV578F1RzGEJ5j0qtWiEnKG9sCciG36mQ5KGoqMzsGXouPGu0l5/5ZjNx
         LEfjrg6DYvdDac55rlSbZa0a2hG/EFFUxxPfmDo30nI3yPErbz+CbgWyjTiyUQ1QAvR0
         0+N4vMHrt/gewYJXOxAubvB/1rbfhaNlqEq9uuO5KpGWOkjWGHWrYUUtuw3fZbj7l9kh
         /DdfQP0nSQallHVUc3QNn59Rgejbavp4WEqYDtgdFEu7mr26XUmZrOC6qaUtS/99kWH5
         MjsdlMEDs5LI0e+GaojmtgCYTfG7ffayRs4wL85zCnmBvJuYj8ohcgVraOUapX0YnC8L
         9zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C0Cpfr3qIzMoBN9F7dCRlBuwVDMbdHyBOSFIiovRDi4=;
        b=GMxGEVu9IVJQILp85jNgjsEiyKDMuxJebjfY27VI5Wzbae+lhwjzkuU/SuflOSWheW
         XEKem9ROpmsxz5Z6N6wsqNhbJGtgeUgv3udeV6I7QDIIVzuw81cNCk7YxTxhmnibtcjt
         PV+XCmMNo5LCxKQYFWTuN8ITnreIMKmQNZjQza8+8YX2CFj8yIIS1nlYCSp9M+CfRVkU
         btD1F3gDoA3IUGbhp/mlrLHN9703d2pOW5yt38JqFDhTen4iSBRmjAyejegbQZJ4MEC+
         K56NHqNUnPVNO9MsvVVEKKn+s2MeFq0yTHsRWlsopl2t4qyyPY+QytcbDekv13AVEeB9
         bNag==
X-Gm-Message-State: APjAAAWoNkQk+QU/XTVrHwY2AZ2t787c8ACEC+urHqx4oZ4N2kqPC2Ip
        D9yeaz/AnzSwRXiqfw7lVOoKhA==
X-Google-Smtp-Source: APXvYqwOb+X2mA+dOQaG0YzpsW0k9MJlUgWO6AvHUfV9BtYZjbQHVhkNioaQSFSv0axslgMmgyq0tw==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr3589289wrw.309.1558088709007;
        Fri, 17 May 2019 03:25:09 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id a128sm7769973wma.23.2019.05.17.03.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 03:25:08 -0700 (PDT)
Date:   Fri, 17 May 2019 11:25:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Philippe Mazenauer <philippe.mazenauer@outlook.de>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: Variable to signed to check return code
Message-ID: <20190517102506.GU4319@dell>
References: <AM0PR07MB4417C1C3A4E55EFE47027CA2FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR07MB4417C1C3A4E55EFE47027CA2FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019, Philippe Mazenauer wrote:

> Variables 'n' and 'err' are both used for less-than-zero error checking,
> however both are declared as unsigned. Ensure ext4_map_blocks() and
> add_system_zone() are able to have their return values propagated
> correctly by redefining them both as signed integers.
> 
> ../fs/ext4/block_validity.c:158:9: warning: comparison of unsigned
> expression < 0 is always false [-Wtype-limits]
>     if (n < 0) {
>         ^
> 
> ../fs/ext4/block_validity.c:173:12: warning: comparison of unsigned
> expression < 0 is always false [-Wtype-limits]
>     if (err < 0)
>         ^
> 
> Signed-off-by: Philippe Mazenauer <philippe.mazenauer@outlook.de>
> ---
>  fs/ext4/block_validity.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

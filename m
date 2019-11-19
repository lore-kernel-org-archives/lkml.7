Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FADC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE01B22318
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 04:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RaG20AKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfKSEjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 23:39:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36797 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfKSEjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 23:39:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id d7so11052310pls.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 20:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Q2xgiO0SCUHCJ01fPdKFNn4jj9dQWkJKPBYAQQCb+M=;
        b=RaG20AKfRfRSNJs29D/cPmOTrEFYL4nPFHgmG5xo24MqBUzPA9NQEETVpH2uFb7Zrs
         OJOYq5t88Af765f3ykzYuaFi1qoYb68ULdaVnvAnmJShKgtwU/zLRNuFRaIuLJykgIRp
         YnzQaZLR17rSR9Aevo+/S+inPEJGDvxiyhlIsrlys7lMUWdBgraaOgjEDCwYnFMF8UGV
         INxfmosBpUAYqmKnb9zYkLLGa1NdIoy1g3EaVL7KWIMiUnAMM5D+OfMeG5PUdkW9DihT
         TsphKiY0fY3NdbTAsKjwwi9dhPriE7wXeLEcYv4nqqaM/qCdAk/xxLEhBsE35Tq5PTLL
         VsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Q2xgiO0SCUHCJ01fPdKFNn4jj9dQWkJKPBYAQQCb+M=;
        b=UDnD4fArvuZf3pPGSQlx35S/Vb0wX+4B2rIqgvYxoSiifmQps4yW8/hAwnT0fJVD0a
         E+xmSUv3c6gQV1UGRTeZwfifKjb7hHLGVceCS6XM9MqtCx22DJXmr008Y9l6y+x7gIfV
         K4b9Nx+Dbpib0Z4IQxJb0wJ3lsmIPAVoCeXFoIemsNeHEWtZCM5BdQEUymK5JdGyDC9x
         NPCCSv0Nwbs/HCDWNc9GEAt01ZRpZUjPTOn9/mW2OqKCedeVwH37imI9wc7aD0UthmzH
         JBAjcCw1am2QGKbqJFlSC4MdgwzJx79YiwEqN1s2M3rjj5wFP5DocN1+n78Xp3+9nGHb
         l/TA==
X-Gm-Message-State: APjAAAUR8vd2BpTIXruC8OByxhHFAKdLgylqrjdYK/bY+RJGJrYLuTcX
        jrt1h6hJHhC1o8KjYgOxVpwYPRZl8dE=
X-Google-Smtp-Source: APXvYqzzV3JKKbYmesiphq/qNjx6W36HWDkmcjzcLqVtGtVM9zWe3dc/jdPtzPqDq4dUmntOc38riQ==
X-Received: by 2002:a17:902:ff14:: with SMTP id f20mr32149430plj.225.1574138355290;
        Mon, 18 Nov 2019 20:39:15 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j7sm20638171pgl.38.2019.11.18.20.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 20:39:14 -0800 (PST)
Date:   Mon, 18 Nov 2019 20:39:12 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v4] remoteproc: stm32: fix probe error case
Message-ID: <20191119043912.GT3108315@builder>
References: <1573812188-19842-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573812188-19842-1-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15 Nov 02:03 PST 2019, Fabien Dessenne wrote:
> +
> +	return 0;
> +
> +err_probe:
> +	for (j = i - 1; j >= 0; j--)

It's idiomatic to just use 'i' itself here. But I applied this as is,
with Mathieu's t-b.

Thanks,
Bjorn

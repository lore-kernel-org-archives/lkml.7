Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7C6C5B577
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B73216FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LLdZE4M2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfF2TFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 15:05:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34301 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbfF2TFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 15:05:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id p10so4075659pgn.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 12:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bTs7ErguXXMoWO56S334gRVdj+FZX2DsPTRLxIpz9t8=;
        b=LLdZE4M2ciYbPY4mOKh8tQHXyqmji0erJvQCPdtNO0fP9nZWb2lrY4/qJkwtJkj042
         zMCSTm5KGLpMUXbxP3emIU4VrLkNnTzRNeZ5zbsDL9u6ZTvr4lt1ytyCSr8FWL2E09EI
         4Mhp//XdkmXj8fZg6oGJrwFkrOefeIV5QLEZV53jSd/InI0z11jDqHRcpiYLEBaMxRix
         FwXOBVcHrySC587/h6TrHFjlGa3m0y+1OEZ8Cm+fgPitY96afTXYWzFTPJPt50GmpJka
         JoyvTts6+nqF+F/zYlzzscC8LZllH6pRLEtJ92cXrp9GkU3Y9UOo3e8aVYDtraiHYoUf
         MYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bTs7ErguXXMoWO56S334gRVdj+FZX2DsPTRLxIpz9t8=;
        b=E/Vx1CQ5jMXLi/osIT/p+7oM56b5IGCrdSF3tQom8YjGqOQUFZ7v7T4KVUkWAbptmt
         ZZ4aWUR3PgJUe4K4/WR1S+dV+DG4K28QwAfvoiGGYhauw0OEST5+klfVar2RhqtUSA4F
         jhYX8fF6RSuh5Nr26AWDkH5EvVNaKF2TtGFRzJWRPEEzEQYhh83F0Sg6pRUcmtJVr2EX
         3nDrHqmX+VVIkA3KLMTYyYWSMK5u0Xxkt9w+DwBhzQeKHFc2CdLtMZ1AzEQYyFFTr/Ps
         Ms9xzAxsmfGheN4lOOWT63jfF3/tgMupsmu0PXhfehozkZoYFj7GP8uV5Kaz3KzAgphQ
         NpVA==
X-Gm-Message-State: APjAAAUFQ8a6Fj68+JJntJje6jzWyl8OFjh1QM90UVxiq+y0r3UkDKPX
        o+wYQC7VmoNnupOqya3AfHZ848Lv6nU=
X-Google-Smtp-Source: APXvYqwFqUQNKvCJEdwC8KlJelEfndpt8UZDkqqrlqpdG3G7Bc2576Sl4aGCvBpkKsTABGZBRezztQ==
X-Received: by 2002:a63:e43:: with SMTP id 3mr1359183pgo.402.1561835130627;
        Sat, 29 Jun 2019 12:05:30 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v22sm1462700pgk.69.2019.06.29.12.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Jun 2019 12:05:29 -0700 (PDT)
Date:   Sat, 29 Jun 2019 12:05:27 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Fabien Dessenne <fabien.dessenne@st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2] hwspinlock: ignore disabled device
Message-ID: <20190629190527.GG23094@builder>
References: <1552064026-11415-1-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552064026-11415-1-git-send-email-fabien.dessenne@st.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08 Mar 08:53 PST 2019, Fabien Dessenne wrote:

> Do not wait for hwspinlock device registration if it is not available
> for use.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

Applied with Suman's ack

Thanks,
Bjorn

> ---
> V2: use 'goto out' instead of 'return'
> 
>  drivers/hwspinlock/hwspinlock_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
> index 2bad40d..d806307 100644
> --- a/drivers/hwspinlock/hwspinlock_core.c
> +++ b/drivers/hwspinlock/hwspinlock_core.c
> @@ -333,6 +333,11 @@ int of_hwspin_lock_get_id(struct device_node *np, int index)
>  	if (ret)
>  		return ret;
>  
> +	if (!of_device_is_available(args.np)) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
>  	/* Find the hwspinlock device: we need its base_id */
>  	ret = -EPROBE_DEFER;
>  	rcu_read_lock();
> -- 
> 2.7.4
> 

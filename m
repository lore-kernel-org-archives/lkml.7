Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF4FC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB362077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIn750bJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgAGGgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:36:19 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54583 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgAGGgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:36:19 -0500
Received: by mail-pj1-f68.google.com with SMTP id kx11so8580806pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 22:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tTZbqF4ps+HLBqOMSUsrvwOLXqstbl63mT0iHeyM9jM=;
        b=gIn750bJf524SYp9mT+vfcFuPZJLCQOYdp4DR/EX3JpLjbjtvN80SdzE/K5oP7F3Uj
         Wq5IMqbumPO41Oz2JlKJdMuY+5pGuUur99UCc9jfX+ln1z6jxKTF3L2jxeL7NDCv5tvr
         9xD5f68svYzmJ2DJApVOB4ZLpKh6SvL2vsa434c/ZPIZ8GSN08RSAy87fBc9RSkJUvO9
         3ion1e2VdkFljqrfdi/s/WB90VAVQmSrM5OzMxBkMbiS+1V1gfpuOFP/Nq2CAi35dUuK
         N1PyrzXZLKfZSgsPbWkwb9gKzEdD3QUhIaWPoUxdUJWJ+2yZDDJUTUqfP4DBZNl8HNR+
         NFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tTZbqF4ps+HLBqOMSUsrvwOLXqstbl63mT0iHeyM9jM=;
        b=m5Z60GhV3svZ4dG52mLLvfpGl4xdJrRrbJKpbe9pJZ0Cw0g7x2MA0ZTlu4+LHt9bJJ
         T9sxKSrKoA5Pt54K/HjiXkd4knaksso0b9vAGU2C8dP053sHMudE5Kh6rVNsMq/FqZVc
         AL1SnmFkyalaBUD+dqB6uk6QWOLdEwpwYNONyCup1VVaP7xSnuDDlGKpUBBsD5eVwnPC
         M9HPsrnkES7Y74OF4xjMjuOH7SYdbvxJvDZHiLbpmMYqI5YfF0N0xtrzFXZzg9pYRo1V
         kQCA+tjy7daMSiG1zc6QenJzLAoi1IJYCUPN60Iu+50N1yPcmBA4grHGX3ihWDdp027s
         74rQ==
X-Gm-Message-State: APjAAAXb/obvi2ukooCgHCC2R2ALw16f/UhTi9eLvMbgr1DmXZFeAYIj
        Hu9Gxd4S/yv6FFUzVnBWWgd9b8o0/yY=
X-Google-Smtp-Source: APXvYqyQ4bRJk5uq7MSi/mXacpXV5m3p/gkpAeQ6/tnMd4dRcssIsiOPw2AcqLSK3K4v0pCaqqLQhQ==
X-Received: by 2002:a17:90a:8902:: with SMTP id u2mr47740347pjn.85.1578378978847;
        Mon, 06 Jan 2020 22:36:18 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id f127sm83164189pfa.112.2020.01.06.22.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 22:36:18 -0800 (PST)
Date:   Tue, 7 Jan 2020 12:06:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] opp: fix of_node leak for unsupported entries
Message-ID: <20200107063616.a3qpepc46viejxhw@vireshk-i7>
References: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8060fe5b23929e2e5c9bf5735e63b302124f66c.1578077228.git.mirq-linux@rere.qmqm.pl>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Discard my earlier reply, it wasn't accurate/correct.

On 03-01-20, 20:36, Michał Mirosław wrote:
> When parsing OPP v2 table, unsupported entries return NULL from
> _opp_add_static_v2().

Right, as we don't want parsing to fail here.

> In this case node reference is leaked.

Why do you think so ?

-- 
viresh

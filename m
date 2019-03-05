Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4424BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0136620657
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551801221;
	bh=wTHNuE9rsaXDAIwxiBz1HrtUtG1NzvGpcLKtj+uoxwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=en0DW1/tZeB7UItmOROf4o2fI1VamUveh97ASclTH46QkClAF0rCgCQ7yQUhtdLW2
	 31XrMyQueFanW+Z7oPfjWfyocvNCtChpuKVak/NA1x4770qktfMl/F80NUeaZ5VFoD
	 fW8sVqJZw5IQlwRkhz+QtkVGwxEh56B31eLAyIuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfCEPxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:53:39 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45865 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfCEPxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:53:39 -0500
Received: by mail-yw1-f67.google.com with SMTP id r188so7296388ywb.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 07:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ndo6yHsDxB1YKkLM3ErbwCy2ePPsRSJB8a7rkScE+pg=;
        b=X5imI1Oshg24kaoqU4364u+9PXYGx+ZGFGvx7KSHQHh1py7TPUc2hwWdArjc/H96uP
         16vQck3sIwDmoTEvsAnoAlnr8aiuHQUw3mcSLh6HmaXHaFNAZlRxGqlth3NoJeRraKBy
         XnpB24CbU+UX9ssR/EZnG6/sJ3HiJt3nwG1gsXJtVPZpnh8Hu/Aw+QKW/S76/ehjRFtv
         Xv2ZjaAdKBxQqyzXDPj6kpOgdoxFo1p5SIMol1fS7ZA/3Tnx4XXKAuNOvyM6TQZRhvuH
         zfDCyrpWpldxZvRTEU3FYgeR+Kq49ny5dKKymIpwMgS2AT3Cc/+RKKOBo70kjAHNzWmU
         1CGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ndo6yHsDxB1YKkLM3ErbwCy2ePPsRSJB8a7rkScE+pg=;
        b=aqawPXGzkpN1IzK/e6AjBnvEu0y65R7k97TPUzcwd9ZtKAZRGmODTrwt8EFE6tYxil
         /eQ/PXtsjyAkN52l4g8IW3GW5KEiRHHuFemPR8xXK3FtVLqtJGLz9qSin0cAtEMJAmqJ
         kbIHFXY0li00rterlOOg7V5cS62Yn0754gjT1m5xVpTN2ac7RbW+RNVy0C/ntgmOxMyc
         kGiBb5b0sK8snEB4PgREGAzMQv9fR/wTH5vJOPhIrmrqkSbWFwQYUZPfRm/EzXivdtIk
         TPfP2wRu25IfTTq/RjK9CX/th+2/dxArsihZj+yLsBC6geBAvMVIr3v6X+aq7m/gefJn
         r28g==
X-Gm-Message-State: APjAAAWyRBxu+5k13PVCQBSaOX0PkwniHX4zja8o6Cgi2vpPK/TJgWzM
        clGj3vti5Ex+jcZl3q9ZmSI=
X-Google-Smtp-Source: APXvYqwe2RfxqpLDnHOQTGNlj6AJ2qgiCrQYjaZFy4d/fI/bQHyZi8+7xY6v4sD+/cREccLcx5f0Qw==
X-Received: by 2002:a81:6c0c:: with SMTP id h12mr1482495ywc.26.1551801218202;
        Tue, 05 Mar 2019 07:53:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::1676])
        by smtp.gmail.com with ESMTPSA id y16sm5057069ywy.90.2019.03.05.07.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 07:53:37 -0800 (PST)
Date:   Tue, 5 Mar 2019 07:53:36 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: Fix spelling in source code comments
Message-ID: <20190305155336.GB50184@devbig004.ftw2.facebook.com>
References: <20190301215725.135432-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301215725.135432-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 01:57:25PM -0800, Bart Van Assche wrote:
> Change "execuing" into "executing" and "guarnateed" into "guaranteed".
> 
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Applied to wq/for-5.1.

Thanks.

-- 
tejun

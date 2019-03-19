Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FEEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1570120863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553017728;
	bh=U/FYaOHLtFnfMbFnpu5XA64U8ZYDa2RXDR5nCIwqKRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vn6x8QRPZH3vjCYarBImFvAn3Z3pOkGXYRxzZ2+IQ4PBU0d2/ZQq2No80/wmp4JLu
	 Ed0HpcZzLYk4DZaDrTFTcXXCym2Mx79ZFihJpwgplBt7Pxtou8WTZFqcFOkb+Hlj10
	 wXtJXEt8Ah69M9gw/lu3m8g3muzf+9y0Oq1B7CmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfCSRsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:48:47 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33375 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfCSRsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:48:45 -0400
Received: by mail-yw1-f68.google.com with SMTP id a199so16629834ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FSD4nDuIVHFT21mJTNBz45kn5Kdb6FdMAdA2HhJmG38=;
        b=JUn6lNoDnvPZ0+HoLzUSlo9uln76pZG1IBY6/ahmcIKgVnioaaaAq12TXTv/qY/82H
         peIerwrMQN3vmZjnossG9DLyWRGbtYGGcvPtnKp9Bq+or5bRluBhHAjJKWd/bW4h/OSL
         BLeMSynZnCFQlnFtzxw5sPK84jJjGqR2hkqQALP8Nb/3zHau/lmdV4qKjsrGlsFjFja0
         jW9ghT/rXi02UvavKw/gMttcgkQH32Jdx9k/1UMVpVlFxLcCANBpEtd4zy2Kfcx6Ii4P
         KWb+8xJLGNWrghBPvx/b2uaoqvuFozllwweRPN2PImUqrMbTX6jwJ6Fgc/BvI/mmB3SD
         NdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FSD4nDuIVHFT21mJTNBz45kn5Kdb6FdMAdA2HhJmG38=;
        b=Kq/N19ifjtmBbK938F90QXJI770TEYImu47m2tj/wg3pN6Q0mV1EagFvVM4ueEweRz
         ZE8yyuJLoouoXUH+uqW3tN7zgIEcROpH6XHIQXkJSwYvmADNaybDLanPcyH1A6sqaD34
         U7ELooHnwvdatQP/u6gf3NmLMP7JgnZ50eUU4/hOTukFhgInefbCYDk2DBJwqcy/M80M
         RA/X5raONOXueDTHxQwnKahRv8zl7Yoip3zZQbM0cj+gFx4eZGs1yCnmc3tLnFHRWJL6
         BpF++XkTJLIN4H7ReYV+wNweWs6pVifxm8ZmVAdrcCb/38DO+Y9gJ4R4XXO2QCV9asOK
         5l8Q==
X-Gm-Message-State: APjAAAWhW00Qu8ZYi7cS2Mtks0jKZVPZ+OH8EMgR6USoMHJTDlEoL2M9
        668cYiFB0gkymgg/Ji5JLiw=
X-Google-Smtp-Source: APXvYqzSpFBdGE2EnJliX/0Dt9p+XjOQSofqhwtZqTn+bpUiCQtGh3JG6AxrVx7GlBwroxJ10DOtuQ==
X-Received: by 2002:a81:a0c7:: with SMTP id x190mr3138299ywg.62.1553017724297;
        Tue, 19 Mar 2019 10:48:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:5a18])
        by smtp.gmail.com with ESMTPSA id x126sm1327ywf.92.2019.03.19.10.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 10:48:42 -0700 (PDT)
Date:   Tue, 19 Mar 2019 10:48:40 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/workqueue: Document wq_worker_last_func() argument
Message-ID: <20190319174840.GB69236@devbig004.ftw2.facebook.com>
References: <20190319174509.95910-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319174509.95910-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:45:09AM -0700, Bart Van Assche wrote:
> This patch avoids that the following warning is reported when building
> with W=1:
> 
> kernel/workqueue.c:938: warning: Function parameter or member 'task' not described in 'wq_worker_last_func'
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Applied to wq/for-5.2.

Thanks.

-- 
tejun

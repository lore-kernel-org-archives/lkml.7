Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1C8C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 19:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3F4216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 19:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="KJJrjVZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfGETrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 15:47:52 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:37343 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfGETrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 15:47:51 -0400
Received: by mail-qk1-f176.google.com with SMTP id d15so8718561qkl.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 12:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=0TATBqQiMRJ8Xy1OgwvCrtN7E0479qACc1+G8V6M3Xk=;
        b=KJJrjVZMwcVKRVxdXd3Infv2AcoRbbkMqHl48nblHvKb+RQSvlvnn2nVucAzWjDzbM
         UZYjR5U6sWoZVn/oDWqUZz+gC1spDq7q0GnV9fVYAekfBZ2MHaqFz3ZxGWWW/vbfna22
         ikTNUpARfV69f5OoZT8bD4be/Ilu0FTCXZXqxCBNdMximq5q1b7UGs4HUVmnnHpxyQcL
         AOrLZ5uLQdCCHKvXOrFDnLICrwMn1j1ynXGoY2QQimBkDAp6jekWS7Wq5Pfj+KqTRD5Y
         t5QtWQQELNSfGrIR5gpQtlo0jDem4BdVFTZOF2FbfdFbLLWVc/d6PyLQJ/p3ML62Lm5V
         WctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0TATBqQiMRJ8Xy1OgwvCrtN7E0479qACc1+G8V6M3Xk=;
        b=P91mVbJCYzcaRdXIqOg5urkgSEpFaiscme4q6HV8+cvOvJZOZv94AbWfXMVzlev81Q
         SZau+YWst8fVylX+eJzySyV7zmTPEiKxVITRUIzHlGEq1obs6plEZRTrbuK9F1LTSB48
         /55kOV8aderPOLqByD1VsWzmMB1BcUVBRdXuJrm0QGRETIbbSyLwucQ/nRKM54OSOpyP
         Ic9l+d9BCsd2EZznwDyYIUDe2D+uuX97//Q9W3tVLUg25ntMRg94Asv1YTzJhi4p4eZj
         4jgkv7yJykEyKwEdNIuWSODKGf7H6dJeEQo5bc9EdHxUJYsY5I1wVO7tFPCYu0m1c8zX
         nGuQ==
X-Gm-Message-State: APjAAAUz5W/S57JQfO7vv4qG0/hfU9TyuuhEnkz5/A63VoEzYx4uInMe
        Oi2MtlchiAlO/vychdyw5h4zxg==
X-Google-Smtp-Source: APXvYqzK/GzELHpqDq/VbTWU7XHrEGs37mvjn3uhf5axhCh746s/ZMrQyrHe44GnAj/DAroDaFcBoQ==
X-Received: by 2002:ae9:d606:: with SMTP id r6mr4393361qkk.364.1562356070790;
        Fri, 05 Jul 2019 12:47:50 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id a21sm827074qka.113.2019.07.05.12.47.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 12:47:50 -0700 (PDT)
Date:   Fri, 5 Jul 2019 12:47:47 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Xue Chaojing <xuechaojing@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <luoshaokai@huawei.com>,
        <cloud.wangxiaoyun@huawei.com>, <chiqijun@huawei.com>,
        <wulike1@huawei.com>
Subject: Re: [PATCH net-next] hinic: add fw version query
Message-ID: <20190705124747.67462b22@cakuba.netronome.com>
In-Reply-To: <20190705024028.5768-1-xuechaojing@huawei.com>
References: <20190705024028.5768-1-xuechaojing@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2019 02:40:28 +0000, Xue Chaojing wrote:
> This patch adds firmware version query in ethtool -i.
> 
> Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

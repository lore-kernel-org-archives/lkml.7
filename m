Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93CCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A672077B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAOUZXuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfCSQDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:03:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39624 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfCSQDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:03:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so7650776wrn.6;
        Tue, 19 Mar 2019 09:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YdILYVFcBdqt+Cx2Qqw1NS791l1k0hHY6kpyCHNeHeI=;
        b=CAOUZXuWm36w7ybzF+V0FuH9FUQSaRGTmtLYgbS3Jb7F9tg9/qHPIbQNYHjXnoBB3E
         oFAzDtrlJpkjF1Wfm0W4FC7T0nGr+bMPPY5/oxe4A/r3Q5s7AqmXbZO52U7cbOmGByKY
         whgvz1+BGnrs50eb8WDZB8mdCaoltFqrMmKCc1HBbpz0UYmk5uQ05ytVwvfEAsDVaFnO
         qEVBjzFyeMB+jA4+cPb6sIr0uJs8lGIEhkTHryQSP4DkxQtmKmpR5XTKwEcDSoaVnZq2
         hUw5UzIqaXE42hzdjDV5MhaZkzVguVuQROWKJ6OWAuLHwDr+PTBe7FWXvxpDFe6Qy7qb
         CpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YdILYVFcBdqt+Cx2Qqw1NS791l1k0hHY6kpyCHNeHeI=;
        b=KFkyQqz0VDK/O+faR0/5j2i+kVDQDFDbLl6pLjacc8QmLBOsl8quc2Azfrf3zjpUMx
         +s03ib8rqOpy5EV2TAHSvsTf6Cqo2nOFQxa1/pHmJq1fikIYT8rlxLaUZlkq8gWG3iXz
         Ynxq9IJZZJPcY7jUMLa43EQHPyP0rCmYEpqBJwv0XXYAtwZO/+ke9sOPgmI7vSuYZGg1
         tDBv2D4vpZgTiQPEdN4B49y20Gr2pU8K61ZeluEkJUCawav1mRpWxue4pdSNmZTaSSRU
         RehJASo92POgqVrmhCSLH7Ypqrzn/1gL03j3RNayL3BajKd1S7KJL+nr2DidGxCGWkgz
         1pQw==
X-Gm-Message-State: APjAAAWbV/ZXTNiuUno+AcPaQr6lJL2S9KKBGoBhMs7jr6RxH51OwJnL
        wbPOJaG+SYKtWMQY6DXvT/PpOIKD
X-Google-Smtp-Source: APXvYqysHE1JjEefZOQyxy38BVmoZJOBaFiLaQ/4GfUhYDa/4UTshuWoiNfVpVlYPHYWTfTMTvqezQ==
X-Received: by 2002:a5d:62c4:: with SMTP id o4mr12335867wrv.282.1553011393637;
        Tue, 19 Mar 2019 09:03:13 -0700 (PDT)
Received: from [172.31.96.190] ([195.39.71.253])
        by smtp.gmail.com with ESMTPSA id q24sm4836626wmq.5.2019.03.19.09.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 09:03:12 -0700 (PDT)
Subject: Re: [PATCH v3] net: mlx5: Add a missing check on idr_find, free buf
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Boris Pismenny <borisp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190319155524.6978-1-pakki001@umn.edu>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <60539cb4-1dfb-d307-f761-61ff5459e3ac@gmail.com>
Date:   Tue, 19 Mar 2019 09:03:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190319155524.6978-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/19/2019 08:55 AM, Aditya Pakki wrote:
> idr_find() can return a NULL value to 'flow' which is used without a check.
> The patch adds a check to avoid potential NULL pointer dereference.
> In case of mlx5_fpga_sbu_conn_sendmsg() failure, free buf allocated
> using kzalloc.
> 
> ---
> v2: failure to return in case of flow failure.
> v1: Failed to free buf in case of flow failure.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>


Please add an appropriate Fixes: tag, thanks.


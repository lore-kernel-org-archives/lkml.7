Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B733EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E58C2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576596187;
	bh=szmX+5i7tJVdpWXi6EhlqqLOQd90ED7WpI36u4s3K0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JG8NHIvEdxTsYXTTT9sENyuye554p49srIk58MqbLMHPLMt/2YftUweWc95/lcb3A
	 U6gcNN8yhYDOuXVi9GHXsxGxuzc9wzqEWMnZ/VSvihlAvxB9VtolCbkK6pu9C9S7yC
	 DDndlX/HZ+r7BxQHokV6mBsJNxeRMglXQrRhKBsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfLQPXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:23:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46177 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfLQPXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:23:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so11699004wrl.13;
        Tue, 17 Dec 2019 07:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b3WyKVkMgpCH/40qULLwIPwhylmii2eDFQ3btP1Ui98=;
        b=WId7/BAl4Dfe/Sfanp0HbvWmqo97XtoegspW2Y1M5D+izJBoF/glPn6te6nYLe5VOn
         VnjWZO+wEw4GGRpCjtQyU1Xr1i7CBMN5vfUXF+rfUfpTaGnwwUQjqWyecvRgp5qsFHed
         by9yma4+LF3kljhriKdwu23ec2sL507Udu6gJC2TZYvVoiueyRjdA0cLdS5DYohphy/P
         B4dR48zE7Q+px9tQYgsh7NuU1+OQ+ZwF7xJ4lDRkpcAMUs37qy6f4hgctSHveu22j4v4
         wgj4p9WGbuLCx7GCI0ThH7j3nAqt+frRxg2TGdj9Ea5VgyCgWJRDgV1ziJG+4BjQ2N3z
         S4Ow==
X-Gm-Message-State: APjAAAVuVINSCOVVqTCssG8t5y3UZ3ylN09x1lg/x4nYIGperUdKTAFK
        aUPeZX2rTr/o47EyoVmUVkE=
X-Google-Smtp-Source: APXvYqzMPuGW1YTYUDf7FTtAnzKOABQxNzRUjTLlFXNh8Hu1qA5HED1iFEzMQpFh8aO9yV6cPWvN2Q==
X-Received: by 2002:a5d:6a8e:: with SMTP id s14mr38758076wru.150.1576596184766;
        Tue, 17 Dec 2019 07:23:04 -0800 (PST)
Received: from debian (38.163.200.146.dyn.plus.net. [146.200.163.38])
        by smtp.gmail.com with ESMTPSA id o66sm3465489wmo.20.2019.12.17.07.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:23:04 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:23:02 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Paul Durrant <pdurrant@amazon.com>
Cc:     xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 3/3] xen-netback: remove 'hotplug-status' once
 it has served its purpose
Message-ID: <20191217152302.i4fp62mevawabwjd@debian>
References: <20191217133218.27085-1-pdurrant@amazon.com>
 <20191217133218.27085-4-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217133218.27085-4-pdurrant@amazon.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 01:32:18PM +0000, Paul Durrant wrote:
> Removing the 'hotplug-status' node in netback_remove() is wrong; the script
> may not have completed. Only remove the node once the watch has fired and
> has been unregistered.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

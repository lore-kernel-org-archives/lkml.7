Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645E9C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED4C20836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575989307;
	bh=2yt/Wrf16n/sFPmsM45iBIgA3Yg7DHwv+gBrMNLCoTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r5MuXT5BwazYkpv9A2BWydwYAcCJUcfiQHiMkQ3qDAF3h7fe4F3U4Ae3W7Hiesl1h
	 afH3HdZO4Dwq6KHKgUr3gm0gZAJ8VbKXqoWfmucFFyJ3eRHNr1OBkZxpj+pf+w/8yD
	 B3ESufoYKatYcYu+zP908pmhiMra3RqzvxKw1EO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfLJOs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:48:26 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43343 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLJOs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:48:26 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so16160735edb.10;
        Tue, 10 Dec 2019 06:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0EAXVyH4ukLLoAvN9134a+PTWSnV2rVkKA3kz84w454=;
        b=h5KeXgX2fo3TfT9n9FU16T6O+zty6qyQjrQ4oW305w3zt0Vy8Y/QCzj9r3ETcD1UVA
         EucQjAUFKUxy5FEdgC8L1nIc3sQfVoQqM9pqJ8NJ98rC82hxytf6RrIO0k68+QilRLc1
         TB8JSwS2dxDCE065Iu1CGVshIs7TJeqszMDt1xadcRFojiYilxrnipsJXO4v6KnBJVtV
         D3bFU7SnIJiqq5xTTewoqPpAM3zdIuOIpZHMo0JhHt0hQez8la6rqpC/6pUj80DR7KSP
         8lif7iRsy7aJqklvHqouLjXKqlGYe3SOTblEtWQf+Ub6vKS8KGGaQfm1Du9S/eXexCYR
         4LOg==
X-Gm-Message-State: APjAAAVpFTX88AAmaYhjR01orgcY+tOkt0lx6DUzomfU347ZaQf0E2H/
        IDLbVvjjrOkwEk7PxbkFCZQ=
X-Google-Smtp-Source: APXvYqzkz+9tUg97oDzo/5cpkoWY+HXY09yTxmkmj/tzpdgZ3zzzXDjzNsMv2ejroiWIPfLn7GLR2g==
X-Received: by 2002:a17:906:4e96:: with SMTP id v22mr4076976eju.219.1575989304153;
        Tue, 10 Dec 2019 06:48:24 -0800 (PST)
Received: from pi3 ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id s16sm82829edy.51.2019.12.10.06.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:48:23 -0800 (PST)
Date:   Tue, 10 Dec 2019 15:48:21 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] tty: serial: samsung_tty: fix build warning
Message-ID: <20191210144821.GB11222@pi3>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210143706.3928480-2-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 03:36:58PM +0100, Greg Kroah-Hartman wrote:
> Fix a build warning on systems that do not have CONFIG_OF enabled.
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


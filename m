Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE2AC17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256F02196E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573615292;
	bh=pK79PK1/VGWQglD6r/hxwT1aIZX+B6g0dmMwyZwXJjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I9U181QjtyIuL5PSWPFCulv4CrZe8obvR7TWPqhPIj4GUR+4AOLq39oyICPtWadHV
	 dCE+K+fUblS2lPcv6x+QsbG3PY48bYWEH0JEZ3UQhBDCV2hvPYji7qfDE4bSf5Hpx9
	 h1gdrXh7hKWtUVWZ5uOZ3ytPdoxUSEzZjblX+Q7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfKMDVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 22:21:30 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38723 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfKMDVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:21:30 -0500
Received: by mail-ot1-f65.google.com with SMTP id z25so382509oti.5;
        Tue, 12 Nov 2019 19:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SzJrfGGjB/WLv221edrkrOTRzZzVy8yKLGHtpQA1XPc=;
        b=F147iNRv+VWZZFOaAHVsGtn3r2O6+rTwBi60yPnv7B+po+vbA6uiDqQOlYvR2ejsG1
         o7VpDbMDtOxh6963Du6Lp/VyuBUQ3bjlkZr9RoaAjbZIO+FHHRvrcEMuOpKiSiJNf7fY
         PlZBm8eHRqLEGA6MZiDx5fwA/et2gy5LXjDx96bXXMnaJtX+rwqTpCYPyMZLG9kgrBVZ
         q/qg5+gI5sTih2t42k/xD7+wn5Yv72aPUAbiEyEZWFxKkJTYPJt4BQGl/LxKKtJPoXPU
         ZuxXu+HluSeVynsPA18q3PMtaXYxlHp+uG/pY9dl5kXE1YQ0Nfp5JX9+k4f7n19XTqx9
         GO5w==
X-Gm-Message-State: APjAAAXYjQ2ULo61DuDYI4qzJcZf1PDjdQv8a27EagnR2yjM19CFbc5v
        p2YdvitAmUUB5aT4c3CqDg==
X-Google-Smtp-Source: APXvYqxePFSjd3TPVcaMub6kCODscfnVp2jQ/QDnl5E6kgpZHVmKfROkqP1E0ItBV2IEVA4XTPGwxw==
X-Received: by 2002:a05:6830:1f12:: with SMTP id u18mr897283otg.58.1573615288583;
        Tue, 12 Nov 2019 19:21:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m14sm315678otq.6.2019.11.12.19.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 19:21:28 -0800 (PST)
Date:   Tue, 12 Nov 2019 21:21:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 7/7] dt-bindings: gpu: arm-bifrost: Add Realtek RTD1619
Message-ID: <20191113032127.GA22397@bogus>
References: <20191104013932.22505-1-afaerber@suse.de>
 <20191104013932.22505-8-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191104013932.22505-8-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Nov 2019 02:39:32 +0100, =?UTF-8?q?Andreas=20F=C3=A4rber?= wrote:
> Define a compatible string for Realtek RTD1619 SoC family.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks.

Rob

Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B936DC00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F16207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575990640;
	bh=5Hhp1Lx+g//kWRZ6b40vsTckNq4qNR5NyhWYr0nnOfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WD9qZTA4AcATmXCHhITwCbaHgnOCCT22E6HW0o20Az+Gr/9TPy0y9E2oL0V3mNdFt
	 lDskvN8FtDNHCQsjGpMZ+C0zM2VNee3g2hYzZsjLV2wAlh9Pgcnww3Eud5XOQ1gpTl
	 gbFlrgFy5xb0slewfDK0S6OvxH94n/5L3yMStRhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLJPKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:10:39 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44485 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:10:38 -0500
Received: by mail-ed1-f66.google.com with SMTP id cm12so16236906edb.11;
        Tue, 10 Dec 2019 07:10:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d3LpfkiOtgnF+YXqBRtQ1uCrUPaBnT2ASogR2NekSgM=;
        b=XclkfJGlqellM2CdZlntzqJvVlkTxCaD2Wq5YHTz82JzPhddn8cj/u0zVuZWEKiIni
         Bd0rXPO+qXwVopn/nT5GR2RKgBgmml/kvWygz60sQmbBynDRYoczKVzPgl53DR4Rpz4X
         Nbb8jnVsszaW2ZAJlrkV6IclFfWHL06HbDtoXKZMWN26ktRXt4MI7U+wpZRGG9F0+H8x
         y8L0n08Sl7p+VjjkONJXVSJcHGkyQspZi5eicYtIsZwAGq6qXqVlOi5ivx7Cu3vlWiKN
         Vmw02NaeU1mW6cBjPtmSfbCYyzhRYdcLCI6aOa1gWIamev54+/9t406TmoLn90K8MR8N
         wIbw==
X-Gm-Message-State: APjAAAWSkzw0qUKbBjs48UrWt59JwsQeYYdV2gWk+uFk/JEEXT6V1Gfp
        miZEA9mX30L7RSZKj9J6Ivk=
X-Google-Smtp-Source: APXvYqy/95q2xb2Iruz/RwPg3uBLj3KDHEEYzGiywSfr9MJZs9R+/4d7za2vV6DsnfbS19wmkp6vdQ==
X-Received: by 2002:a17:906:cb8d:: with SMTP id mf13mr4075579ejb.147.1575990636835;
        Tue, 10 Dec 2019 07:10:36 -0800 (PST)
Received: from pi3 ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id a13sm68936edh.22.2019.12.10.07.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:10:36 -0800 (PST)
Date:   Tue, 10 Dec 2019 16:10:34 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] tty: serial: samsung_tty: use standard debugging
 macros
Message-ID: <20191210151034.GF11222@pi3>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-7-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210143706.3928480-7-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 03:37:03PM +0100, Greg Kroah-Hartman wrote:
> The dbg() macro for the driver is not needed at all, all drivers should
> use the common dynamic debugging infrastructure, not roll their own.  So
> delete the custom macro and convert the driver to use dev_dbg() instead,
> providing a lot more information than the previous macro provided.
> 

Since now we have early console this should be functionally equal and
makes sense.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


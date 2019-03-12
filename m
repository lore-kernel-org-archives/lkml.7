Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0939C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A816B206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552415513;
	bh=C7CA8Clj7k3HTellivVdZr+nKNMNBhvFBDafW9Lun7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yQWmIscRm1FrEDtWGXIGajmHu6GOcTT4wwKf6rBM5bJoD+As1I7knxnI7mz5bUkC7
	 ejTGOQq6Yzen5YRGunxmf3uk5tLFK8tv2pTBabDaVEBhZl4fcSgcd9TMkGnxKDQrwC
	 k46l8Gk4M2NnD2ppiGmb6vHCpDXXPJE1OHqm1TOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfCLSbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:31:52 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45340 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfCLSbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:31:51 -0400
Received: by mail-oi1-f194.google.com with SMTP id t82so2911409oie.12;
        Tue, 12 Mar 2019 11:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ouAdwyjr2qNz73G9CWAznr+5Z1iaBbbvv1n+gDGOhD8=;
        b=n0HYAUq2CcE7ujur4CXQeaSfEC3pYuf0o2xzWoB/ksZqz0vySPhC4ZfYs2Gcn31KcO
         KsVYsGRNWDV5E2FI9arz1jqxnxSE4IswtuC02Q3aGvm3yehLbb1eJ2Wt1rFmfTujKowf
         64b6lGmvPGYrlaTvIAk4bygAtFARp8TW93fiV1YRF/b8OlnuiD2qmG1oFZokRIvsRvYd
         tAzjcN1D1QFdVSimrgEkQUVIHSqOVQHPGtJpYPjcYmkPxjDj2KpD/0CCT4lsySZfRFnH
         FptRxe/RwITEHEY7pIvYxSa7bb/DcMPcREMhTJf2toCxhmzMRp/3I/DhHcX4VDfso/Yh
         SK4Q==
X-Gm-Message-State: APjAAAXagabivPvHOdz+YJ/ZXQ9UNsu8gu04cBsJUITBIwqJG7AcHTnj
        jwBLSsad21k+cnNWwkhVWQ==
X-Google-Smtp-Source: APXvYqyeQ6z7T2ypLkim6JZe+hFYiV5XYZ8MBNryX7d2TJnTavvIy6x0/Qyeo/Y5TK2cUNtGwJAOiQ==
X-Received: by 2002:aca:d841:: with SMTP id p62mr2697171oig.56.1552415510881;
        Tue, 12 Mar 2019 11:31:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b7sm3569288oti.71.2019.03.12.11.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 11:31:50 -0700 (PDT)
Date:   Tue, 12 Mar 2019 13:31:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: meson-g12a: add cpu clock bindings
Message-ID: <20190312183149.GA26591@bogus>
References: <20190304131129.7762-1-narmstrong@baylibre.com>
 <20190304131129.7762-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304131129.7762-2-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Mar 2019 14:11:28 +0100, Neil Armstrong wrote:
> Add Amlogic G12A Family CPU clocks bindings, only export CPU_CLK since
> it should be the only ID used.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  include/dt-bindings/clock/g12a-clkc.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

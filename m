Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01ACC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809E2205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552407221;
	bh=R6frdUt0h7gwLKvF5Lt5OO14+Bfxtgd/WXsxtyu3giQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uehKngCCFe1CM986AJ1XoZ4rWPVw6p7Y97NnlIkBXoG9oh8wi+TsI+zXQZ2uMmaPJ
	 7cPqD4hsvOnT2RWRcHFBVgHVlG4GceDzjO7oS1AQz2HEi0NXC0BGBnxjO9mx+0NAYL
	 DpEN5gqhL4sWhUwJivb+SrdA6fA1HC/h8YcY8hSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfCLQNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:13:39 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42632 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfCLQNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:13:38 -0400
Received: by mail-oi1-f194.google.com with SMTP id m4so2198655oim.9;
        Tue, 12 Mar 2019 09:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MrKbHZcVt1+np1Ngx/kaljrjrUgKgLYFFfAC2nGvBnU=;
        b=QIlfJHca3fSsbCtcUZ7zdhno6eGWiRfrykg5lbuPyE4b9SHcfm4XiQ1GYhQlY7qMwp
         aTGHtj5rPhtpJU4XcV6rX3pUVYxvfHhVsCxZWdYZOT+PpMKenlYy+zBSkloyBKUCIYZU
         N5Ya65iDzWcbTCNZvOQ7uw3RjYZ7PGb8fROpTYUuhJPPcXdtryxR3PwxxKX5FLb2n32s
         9yMw1mjFeSgYr0lTbE+oB6ubxhPOuT5UiSSLrdT4hsHBrJG6GwJsqKP0DEGWs1jDm7Uc
         gzL1M1CNYspozM8MKEKLozICCd4Uy9xOTrGEwx5JYVoWT5nzp8wdjU0QPXY53Rb79oT1
         BZ+g==
X-Gm-Message-State: APjAAAUkRoXkqO2cSv+p5lcmdJcx3YNx8aoZDwDhoOT+bBHxj2wbWTux
        S5vCbs2eyuvyQoWD0nMVQQ==
X-Google-Smtp-Source: APXvYqzoABGQan3eeW13Js+VlGJ8e4VB2jYyHUJI45cUsEwQZCcn/eD5RRoZZsmejWvvja12UhBs3A==
X-Received: by 2002:aca:dc8b:: with SMTP id t133mr2267731oig.25.1552407217553;
        Tue, 12 Mar 2019 09:13:37 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w200sm3528590oif.13.2019.03.12.09.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 09:13:36 -0700 (PDT)
Date:   Tue, 12 Mar 2019 11:13:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 mailbox 2/3] dt-bindings: mailbox: Document
 armada-37xx-rwtm-mailbox binding
Message-ID: <20190312161336.GA29174@bogus>
References: <20190301042341.29484-1-marek.behun@nic.cz>
 <20190301042341.29484-3-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190301042341.29484-3-marek.behun@nic.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Mar 2019 05:23:40 +0100, =?UTF-8?q?Marek=20Beh=C3=BAn?= wrote:
> This adds device tree binding documentation for the rWTM BIU mailbox
> driver on the Armada 37xx SOC (EspressoBin, Turris Mox).
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  .../mailbox/armada-37xx-rwtm-mailbox.txt         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/armada-37xx-rwtm-mailbox.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

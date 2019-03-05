Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EA4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AE3206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="sFXf+pvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfCEBqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:46:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39264 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfCEBp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:45:59 -0500
Received: by mail-qk1-f195.google.com with SMTP id x6so3973172qki.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 17:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=npvXkoC6Vo4zP/J+jx7B8TsyU0LaA/s87bcgbAVERAM=;
        b=sFXf+pvyjk6llieLEmXvPiPbldw7MhCg5YTHp1eGxrhXeS5eVyjO55jRStio/dgv4q
         hz8jW0eUFYoUzAKcyGdsYPDsEwp8MdOB2AsvLLNYYubgzInZF5p74WY/hBM1JT0sAl3v
         aFuatKLrXC9Z4YI1rUovBZxm8ULDW4OKZXyaxpvUxWQE2bSCD8v5tq15lO9YoiTLzX6h
         SbQjwvMAjjcZ2u55D0m327uDvT6X0UACKg/TkpBrJrvCQLvjXUGW2SQMD0774tw/cRux
         vANlqamJYBRbDIjmQN47hzfTgdEPea9jxFUFOh5rxOw6Gu8AxlDl/ru9hNvwX9MhHdKH
         LtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=npvXkoC6Vo4zP/J+jx7B8TsyU0LaA/s87bcgbAVERAM=;
        b=hvW1qh1ejh/f/11XNaxaYGSYUvd2LaMZL6hAuJn00kxCXy1RwfeZ2KOB8RViiZ07YY
         kURkRXwVMoHGM/arEWDs6jv/vWp6MKsM+DOdn9M622LIRw3T4eoK5i8ZeE4Six3JSTxc
         JrVJ3KGbD9Zv2WaPhulqa0YwdD11OxEisKjV2HLMrA3QlIBWfR93IpuooYiWa5oZvtej
         Vakl6L0Oa6G/Z6JtaaHNP0tSenJHwEVDVvbbzBK36WPo5yR9BqBbn001nUwjVwuQ98CH
         Q6gbpumsITaqAANWK8+WsZn4bIHDVf0hf171Im5XDw5uJaKsoheidxs6RWAmTIz5jvXR
         uxow==
X-Gm-Message-State: APjAAAWO+yHIqkqng4xlOry2poqZPXDFGpOUQrJwpQevbxiyisF5nL6h
        72SVW/InuZyam9JDxAt7UFlpYw==
X-Google-Smtp-Source: APXvYqxGfjOdfYJU9+/2V7/iBwIF7M2T4OKTx5Ixp4H9GwtiT2z0eSU0mCYUiQJvp9HxbOspZv01RQ==
X-Received: by 2002:a37:aa0b:: with SMTP id t11mr24779qke.241.1551750358517;
        Mon, 04 Mar 2019 17:45:58 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id x17sm4536141qka.94.2019.03.04.17.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 17:45:58 -0800 (PST)
Date:   Mon, 4 Mar 2019 17:45:51 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Or Gerlitz <gerlitz.or@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jiri Pirko <jiri@mellanox.com>
Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink extension
Message-ID: <20190304174551.2300b7bc@cakuba.netronome.com>
In-Reply-To: <VI1PR0501MB227107F2EB29C7462DEE3637D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
        <20190301120358.7970f0ad@cakuba.netronome.com>
        <VI1PR0501MB227107F2EB29C7462DEE3637D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2019 04:41:01 +0000, Parav Pandit wrote:
> > > $ devlink dev show
> > > pci/0000:05:00.0
> > > subdev/subdev0  
> > 
> > Please don't spawn devlink instances.  Devlink instance is supposed to
> > represent an ASIC.  If we start spawning them willy nilly for whatever
> > software construct we want to model the clarity of the ontology will suffer a
> > lot.  
> Devlink devices not restricted to ASIC even though today it is
> representing ASIC for one vendor. Today for one ASIC, it already
> presents multiple devlink devices (128 or more) for PF and VFs, two
> PFs on same ASIC etc. VF is just a sub-device which is well defined
> by PCISIG, whereas sub-device is not. Sub-device do consume actual
> ASIC resources (just like PFs and VFs), Hence point-(6) of
> cover-letter indicate that the devlink capability to tell how many
> such sub-devices can be created.
> 
> In above example, they are created for a given bus-device following
> existing devlink construct.

No, it's not "representing the ASIC for one vendor".  It's how it works
for switches (including mlxsw) and how it was described in the original
cover letter:

    Introduce devlink interface and first drivers to use it
    
    There a is need for some userspace API that would allow to expose things
    that are not directly related to any device class like net_device of
    ib_device, but rather chip-wide/switch-ASIC-wide stuff.

    [...]

We can deviate from the original intent if need be and dilute the
ontology.  But let's be clear on the status quo, please.

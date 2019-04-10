Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9697C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AFD20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEMcA1F0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDJUln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:41:43 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54534 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDJUlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:41:42 -0400
Received: by mail-it1-f193.google.com with SMTP id a190so5824146ite.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 13:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lz3wAtCmLAd4D7EBLU09w71eJR10vtiZWJnuO7gxOzU=;
        b=KEMcA1F0wd6boMvahsP4zBwTs49vf30A9nb+zFzHhSw7R79DyDqapp1VhjheGCC7XT
         GIZ/c89RiMR3om6n+zeodzHHEj3fjf4rqB2jsiH3x14etdPMuWflS1DQlqRaNEt/+W46
         94iYrQvIaTdolIQ5t0qVclT6iT4c2EMwPUY6WHvCmqiJctewxHKAp0xL/vrOrdaiaF1y
         XeKVknwF4x8ypvR+G41RIE7zmmvjriyflAy/6Bm610NeYnHE7WG/fO9+ca+pMDQwES4x
         bj3KD1AP5JB9QZARNzH7EnBXEUcrs+j1g3M7HuZ17Vbsr82TfTHtI04AkWSW8EEovWRF
         sYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lz3wAtCmLAd4D7EBLU09w71eJR10vtiZWJnuO7gxOzU=;
        b=hLw3bWqlDp5Gjt0MgPd4ed64gv2Hd5wTEurzAKWl3KyJkomcQ2DFYsZ1SW2bCmUmtf
         tZoo+rEk7b4fp9BM0gTNNmUa74/aN0Uar206229kQXvi68BNJZVTMc5n6Tspxx7nW1ts
         nZ3mR3GKGYmFfb0EwGzBXTxQoklXaFwhY/72BxpBgIoZaRqbcYK+k6wno2H3ySlMQ4tV
         dZawuXBeqObvWPwmyVx9LMUzqcu7fR7rDSeBQtjQOiTIqNoFZUhz7JKVVLlehbD8WlbT
         UD3JYNCISl1jX2O/58y65rkgLPxPvszydTBK/v65YoGvDzXd3JtNrXH/uoOsv+ipL8Yt
         3a2A==
X-Gm-Message-State: APjAAAXeET8Bj6od3mjoH47jN6WY9qaVSjB9F/xIb1MJiNETEdkwHtxL
        AUvxH2J2r2AZBHVARjRkZ4T+Khb3jDWVOykc
X-Google-Smtp-Source: APXvYqz5372kfT9YHtPVBbxIcXhIwFmOKfLFcw/W5+3xoockdARMz26RqsNxQxTRVsafn2YMurY/qg==
X-Received: by 2002:a24:3dc7:: with SMTP id n190mr5102147itn.62.1554928901636;
        Wed, 10 Apr 2019 13:41:41 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:4f03:26b9:1e31:4fda])
        by smtp.gmail.com with ESMTPSA id m81sm1640790itm.33.2019.04.10.13.41.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Apr 2019 13:41:40 -0700 (PDT)
Date:   Wed, 10 Apr 2019 14:41:39 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     linux-kernel@vger.kernel.org, zwisler@chromium.org,
        djkurtz@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] cros_ec: Add trace event to trace EC commands
Message-ID: <20190410204139.GA144469@google.com>
References: <20190410202409.241507-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410202409.241507-1-rrangel@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 02:24:08PM -0600, Raul E Rangel wrote:
> This is useful to see which EC commands are being executed and when.
> 
> To enable:
> 
>     echo 'cros_ec:*' >> /sys/kernel/debug/tracing/set_event
> 
> Example:
> 
>     /* cros_ec_cmd: version: 0, command: GET_VERSION */
>     /* cros_ec_cmd: version: 0, command: GET_PROTOCOL_INFO */
>     /* cros_ec_cmd: version: 1, command: GET_CMD_VERSIONS */
>     /* cros_ec_cmd: version: 1, command: USB_PD_CONTROL */
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Reviewed-by: Ross Zwisler <zwisler@google.com>

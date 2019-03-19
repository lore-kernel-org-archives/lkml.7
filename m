Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A32BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D772085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552991828;
	bh=6QQEH+OEJrKeA/aKnJfLARUYhqe3Biq3NcvMSxbd1KI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ny5F2swzNgmS5Jq5vIc+ZgFiJAkpKn6iiC0EUpA5wpBmZ4vaD8Hb4IwdWiK8UnoJT
	 EiqPkeoAvoK8/qSGJv9zagZzl5shxuKVCV2nrGotBTQCIMD/X+FL0i6i9r7NlKC8fA
	 Cxk3NnbCyiw04Sx0uu5F/yt5pS0CjEbFuWwzaMbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfCSKhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:37:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36625 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfCSKhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:37:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id v10so16832659lji.3;
        Tue, 19 Mar 2019 03:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6QQEH+OEJrKeA/aKnJfLARUYhqe3Biq3NcvMSxbd1KI=;
        b=LGRC4NBSbCi+xxckNELOCSO1Ce5aT2MjOpCXMzzZ/xssJ9zKWfHZ3pumKURNJRaKc7
         niWRPdIzShyIpOqzdN98DpJtZmp4ZU+ug7GGosqarxqc+TA34Lf3S1HH3GkWg0PpJLTu
         StrL3C29boQfDwYBA0hWFsie1FiBtk46JOsS5EmdI38ufOsi3lan1VuixR2tvdcc/6gW
         9wR5n8XN1HNp/sPXNzCvw94YiwNonJFUN2YgIWrckK6QOKNt0QjsnHksaMgSqLZvzfzW
         YGJoZoo10W6LNklwGDTKaKEfAETCWfcDrqnjfUbU6urk7CWBGYR6eC2jGHDDvLJwCGu/
         DivQ==
X-Gm-Message-State: APjAAAWJ2fujoplIJDnP66Yf44zeTQdJkZ1xQmCwnIhIW5WxtUqLOKa/
        yD0SpScOaDDtQsqkHZRIYhI=
X-Google-Smtp-Source: APXvYqxydxbagFOlqph8aG/r57eHFkAFLZaoJ5UgHdWX0UySBhzTXtqz0XwYdjP0PvHA+8aGuAPbSg==
X-Received: by 2002:a2e:8905:: with SMTP id d5mr7637944lji.59.1552991824850;
        Tue, 19 Mar 2019 03:37:04 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id o12sm2668801ljc.37.2019.03.19.03.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:37:04 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1h6C79-0000q3-Ek; Tue, 19 Mar 2019 11:36:59 +0100
Date:   Tue, 19 Mar 2019 11:36:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Karoly Pados <pados@pados.hu>, Johan Hovold <johan@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: cp210x: Fix GPIO in autosuspend
Message-ID: <20190319103659.GA3178@localhost>
References: <20190217175901.3986-1-pados@pados.hu>
 <1550481432.11088.4.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550481432.11088.4.camel@suse.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 10:17:12AM +0100, Oliver Neukum wrote:
> On So, 2019-02-17 at 18:59 +0100, Karoly Pados wrote:
> > Current GPIO code in cp210x fails to take USB autosuspend into account,
> > making it practically impossible to use GPIOs with autosuspend enabled
> > without user configuration. Fix this like for ftdi_sio in a previous patch.
> > Tested on a CP2102N.

> your patch is looking good to me, but I am afraid there are issues.
> How do the GPIO lines on the device interact with USB reset and system
> suspend?

What was your concern here, Oliver?

Johan

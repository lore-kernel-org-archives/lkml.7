Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71543C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473C6217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558523999;
	bh=EJqa6vIrlc7iUtHtHv7LmP7+/zJB6s8WU/7gMPToHfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zu8b527RWojPtGXel5IgsoxiX/4UO6+mWG7UVQFE+N5Q+4pT7gxs9C6GvNdfvjGiS
	 vdVWcxPYupEg8kXF+jxVMORZqt+uDDNm+j+WR51xC2vikFLE9LApxiiCIEh1rIavOH
	 2uEMIpJ3pjow3hHHfJ1qFzrMWjQeSINzaXWY05K8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfEVLT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 07:19:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39087 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfEVLT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 07:19:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id a10so1705364ljf.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 04:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aDEOHLbThaAOrDh8nCFZtKoptlkry8ATyPbbhna2T2c=;
        b=IeqE36Ob9j2bGMDV32NUuL+dGOTVVxNrQF7u2+2Dwou+VGzpANdAbpDo0J4GX+sVrn
         COaffko3AkwNCF/yfjadzvkt6nwuo8iv9ZRDNW9id8unzm08U5HG78vzCfzosS9EqcwF
         t2SgAyX64JYrrTP2rqNDLnhYmXOonuzeF+rx4MbmLoLZ/OXMRbfiDDmT97RemKVf6m3l
         zMaFDlpsXPkgnZTfftmACQtqJOtfIVzJZUhj0XvFBRDoNbNot5X1GuSx7si7fwuhkPuU
         IqbLh7hJiCc6V62A72MUIf5i3MmDdJDBYVKDjKovx+JvpU+kzlIkKCHngzq5lm1laf/0
         KxLw==
X-Gm-Message-State: APjAAAX6DdS5B8xzrBoDk5QJIYsmQQG5BujSRufVxIDt9zL1+zw8Aek0
        aI3vrBL9NMQzH84wFX/Z8TmvFc7VoGc=
X-Google-Smtp-Source: APXvYqwBkG3hcq/kAttPQg7Hq7zACYdK159f/qpUEED38jToOE4nO0XwDTCryhU4zDDli+Q1HAPOtw==
X-Received: by 2002:a2e:874b:: with SMTP id q11mr16259160ljj.48.1558523995828;
        Wed, 22 May 2019 04:19:55 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id h2sm5378093lfm.17.2019.05.22.04.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 04:19:54 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hTPHh-00035L-Pd; Wed, 22 May 2019 13:19:50 +0200
Date:   Wed, 22 May 2019 13:19:49 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty_io: Fix a missing-check bug in drivers/tty/tty_io.c
Message-ID: <20190522111949.GB568@localhost>
References: <20190522014006.GB4093@zhanggen-UX430UQ>
 <abc68141-df99-1ae1-ea51-c83bd4480d92@suse.cz>
 <20190522080656.GA5109@zhanggen-UX430UQ>
 <3a3db304-9725-6a90-65ac-dff09ef31aae@suse.cz>
 <20190522102900.GC2200@localhost>
 <20190522111354.GA5849@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522111354.GA5849@zhanggen-UX430UQ>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 07:13:54PM +0800, Gen Zhang wrote:
> On Wed, May 22, 2019 at 12:29:00PM +0200, Johan Hovold wrote:
> > Where do you see that the kernel is dereferencing tty->dev without
> > checking for NULL first? If you can find that, then that would indeed be
> > a bug that needs fixing.
> Thanks for your reply, Johan!
> I examined the code but failed to find this situation.

Ok, so your claim in the commit message was incorrect:

	And tty->dev is dereferenced in the following codes.

> Anyway, checking return value of tty_get_device() is theoritically
> right. But tty->dev is never dereferenced, so checking is not needed.

No, sorry, it's not even theoretically correct. Our current code depends
on tty->dev sometimes being NULL. Your patch would specifically break
pseudo terminals.

> However, what if in later kernels tty->dev is dereferenced by some
> codes? Is it better to apply this check for this reason?

So for the above reason, no.

Johan

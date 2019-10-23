Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C49CCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8462084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571822583;
	bh=xM47tMjvVTJk78I1R2uBA4cSFStES95D44l8FAkki5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xuEd+7ahDNk2+q8h3WN+He4xOAcfHxX2nV6fBJUiS7Jxgnu2IO+Vqd5nvCPOwjreL
	 0dJm1u+xI4YbFG4jvfByDZzgEQf1ZT1SpBtuBdKdImtvPaMFWqckxTmvPKyeVONpvZ
	 64SMyCbZXv8P6x10O6NYoFCejOPRKMgGwH03Pdrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403829AbfJWJXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:23:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45910 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390380AbfJWJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:23:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id v8so14872824lfa.12;
        Wed, 23 Oct 2019 02:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xM47tMjvVTJk78I1R2uBA4cSFStES95D44l8FAkki5w=;
        b=eVYuBZtRRyK9nzSFkGqFmz1tzJ1KVjf/d4qiaqgFRaP71gUc7GxDVmb1gBs6F7fIId
         WyF79GWZNDM3vLBIwebxKVB1fBidi94E1RszNVPGAnti4PJnkXiN+R9yP7JGixNOugf5
         EnwQnhgzaXdc+rVKYJvDFbSbzweavunULECtYRI1XdZzRL/u/20OvfdrBZjaDeaOgIin
         b2QG4dQdUNKaAGEy5JRRzyXp74oJ5e8g73IgnWViTZ1jzeKJtdIvtpwGFd70eHMwclUz
         7LzBeooprsqdvskgXOIv9muVeAFBchZfmNdUNocFSQ3SQ91/4XUgPtBTy+cFDALTGutl
         5WwQ==
X-Gm-Message-State: APjAAAVuf52QFgefed+SKX+sYPpLWAt5epssbawST0Y4DtoPkl/3nb28
        jyucbDSN7AH6jXrFoGJaICM=
X-Google-Smtp-Source: APXvYqy/9o2C1CjcTLjn28ZhPCdYqzhGE6WGLj6PQlKcUwdjhezwvdvOSSj7cu+LwVQMiTzZNCVeQg==
X-Received: by 2002:ac2:44ba:: with SMTP id c26mr9442284lfm.20.1571822579520;
        Wed, 23 Oct 2019 02:22:59 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id v16sm5139294lfg.52.2019.10.23.02.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 02:22:58 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iNCrL-0006Xt-J7; Wed, 23 Oct 2019 11:23:15 +0200
Date:   Wed, 23 Oct 2019 11:23:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2 1/7] USB: serial: f81232: Extract LSR handler
Message-ID: <20191023092315.GS24768@localhost>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-2-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923022449.10952-2-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 10:24:43AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Extract LSR handler to function.

Try to always provide a motivation for your changes, don't just say what
you do (e.g. mention reusing this for the new device types if that's
what you plan on doing).

> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>

Johan

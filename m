Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D8DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C388206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prbs1dP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKUKIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:08:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52095 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUKIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:08:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id g206so2761044wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R4hjhKPyQPWEsWK0HmI2zX8e76pSPH6drX+KAe0V84E=;
        b=prbs1dP81sRgtZ7wMCz80nqk+aX4U4XK85NdUe3WyuZaaGzWb6qcXqMherEtvNOdfQ
         0mFggBF0xyVTaVOrAJi9kBoL3Wz2rHwKRiBtK9dd0Cix8BWDWQTxqphMaHDloq0dR2uW
         cfaEJuWSZRXBi3t8JQ1a9RiTet71dpIlmxSrix9fiPhjr6ViM4JByd+qlWkc1Lw9s6Dn
         MNPXnRbI/U7zcw5K40Cx1EmUwjrSZKUjVf6KH4pEa+ucjPeoQioSZwwvYerH2K54/sZ/
         SB33awdggXTa/GgebY19XswcrwnmF8mLAP9YsQ3US8r9L3ZqbmEsEPGe693crpzqwMIp
         imEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4hjhKPyQPWEsWK0HmI2zX8e76pSPH6drX+KAe0V84E=;
        b=j1WTb3LxI8ooQ4EPlxO/B+GXUUUVB47TgzGBGROemCC7iD0a4cf1i7CyWg65df8Qdc
         FXDjee++EI/XOlJxDrrgTqUfh9GU4HCt4DSDUrfuey0T9HtAb6QPw+48HAy1kJdr1uCx
         EdzCIWiGMLWPzo+01IhD3azFVfo1B5PBPuFB2awY3UiewT19NTVm2yjisInowJyFULZN
         fnF2ukJJD2uZyqd9eqwzQAAvbQnHXHKiLhKAUEmw7lXwGoVQijpr35g0w0hieT/mpRkP
         iWL76rBGSUTINYgrQEq9iJePK3oSkCKsFiMEJ0gRSMJCd6alcP6otTI+yvzIgdnG518i
         6s5g==
X-Gm-Message-State: APjAAAV1eVDceEVQYe+U21pXhhWdXiJbF77J7EL13AWbYkB+sQWDz6pW
        XXWmFZ1Ce8MPnZiWbYfBZRc=
X-Google-Smtp-Source: APXvYqwK4BLAl1njfaoGUIR/wJpfPYIvklCz7Cwdpuk+lsOrpbr4tVRvmsBX1oWogL8be666keQqvw==
X-Received: by 2002:a1c:e08a:: with SMTP id x132mr8950374wmg.146.1574330927887;
        Thu, 21 Nov 2019 02:08:47 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40e1:9900:4082:8c56:ea03:cdcd])
        by smtp.gmail.com with ESMTPSA id y2sm2568116wmy.2.2019.11.21.02.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 02:08:47 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:08:23 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Lippert <rlippert@google.com>,
        Patrick Venture <venture@google.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] aspeed: fix snoop_file_poll()'s return type
Message-ID: <20191121100823.2twowr42nsyykvgg@ltop.local>
References: <20191120000647.30551-1-luc.vanoostenryck@gmail.com>
 <787e54c2-2fe3-4afc-a69b-94771726194b@www.fastmail.com>
 <CACPK8XfO=F-BtCuDqyQODJv=6joYmyFiQ5eOYC5YuDJhcLSJtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XfO=F-BtCuDqyQODJv=6joYmyFiQ5eOYC5YuDJhcLSJtw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 02:52:39AM +0000, Joel Stanley wrote:
> On Wed, 20 Nov 2019 at 05:42, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > Looks fine to me as POLLIN and EPOLLIN evaluate to the same value despite
> > the type difference.
> 
> I assume Luc was using sparse to check:
> 
> CHECK   ../drivers/soc/aspeed/aspeed-lpc-snoop.c
> ../drivers/soc/aspeed/aspeed-lpc-snoop.c:112:19: warning: incorrect
> type in initializer (different base types)
> ../drivers/soc/aspeed/aspeed-lpc-snoop.c:112:19:    expected
> restricted __poll_t ( *poll )( ... )
> ../drivers/soc/aspeed/aspeed-lpc-snoop.c:112:19:    got unsigned int (
> * )( ... )
> 
> If you fix the return type:
> 
>   CHECK   ../drivers/soc/aspeed/aspeed-lpc-snoop.c
> ../drivers/soc/aspeed/aspeed-lpc-snoop.c:106:45: warning: incorrect
> type in return expression (different base types)
> ../drivers/soc/aspeed/aspeed-lpc-snoop.c:106:45:    expected restricted __poll_t
> ../drivers/soc/aspeed/aspeed-lpc-snoop.c:106:45:    got int

Yes, but with the change s/POLLIN/EPOLLIN/ this last warning
is not issued.
 
Cheers,
-- Luc

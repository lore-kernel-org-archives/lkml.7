Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BF9C606D3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FE932166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562639606;
	bh=0GnXi3SCUmiE2O/8DIA2BOwvLOGYrFkGj4O5hmrnMwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XtDN9Ji4sE/+jsAJ1Nvxn1kI1wIHWAoVI3cqsfpQ7eAeckFsQ9FxWO55htv1JOjhE
	 r17iaG5LmUmtl20ZzirlIMY4J7/vwTbF6NL8eKhwZGXxWFlyo45qd1KiFGd9N2Ilpj
	 9NKzRA2CKCSvDFK3JQGgKiE3F+ZzXoJ7a1uAIEiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfGICdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 22:33:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35891 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGICdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:33:24 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so24291732iom.3;
        Mon, 08 Jul 2019 19:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ecEsPgHi6Qvo6EJzKEnD4OCkuoJ/yms2Gr44dyNSi+0=;
        b=lVfR6jOiRQwc2aS9sJWdhPgkUqnk0bB8OPDaUjQEgmxpsZMt3pz2ycBCNgaKfy/24q
         81WR8PZZQBOum3a/vCJNcXM/rg3bmPPr3ZC28x2dgBn7ZPutWFIuNKuVaxAkOKUZ8NGy
         tklqre5WffsQeJLzEmwrrKoJuNNZ0zTWNemSHiF/+aa6RjKn67FpAInQGyjrw7WBbuM/
         tVOuaa8OfmnjtHcVn0oS96fPjr1Vjy4U1vIcPkcKgLTF/4MHTtfiwGwYL044FcKUwl9n
         vGkhz2pD0fsBNO8mRXRdVmQX96N30oV4mqBiKBXRvwVCF5JUZPtHXlLfPmDYDQ7QAnbG
         6Txw==
X-Gm-Message-State: APjAAAV3R14nxJN1A8RuVgcxL3e8/pJRWBqFRCS1Nse0CxwNprp9PCXj
        EbjDxtbQss720NzTK+PQDQ==
X-Google-Smtp-Source: APXvYqy3mZk30mYkqfKXfCPVRP/D5lbixYB5eUCl1BDUmEktnw8E6DsRRshp215GSty3pkURJ2nNEw==
X-Received: by 2002:a02:3b62:: with SMTP id i34mr25585721jaf.91.1562639603766;
        Mon, 08 Jul 2019 19:33:23 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p63sm20342322iof.45.2019.07.08.19.33.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 19:33:23 -0700 (PDT)
Date:   Mon, 8 Jul 2019 20:33:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dehui Sun <dehui.sun@mediatek.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        erin.lo@mediatek.com, weiyi.lu@mediatek.com, dehui.sun@mediatek.com
Subject: Re: [PATCH v1 1/2] dt-bindings: mediatek: update bindings for MT8183
 systimer
Message-ID: <20190709023322.GA5141@bogus>
References: <1560252534-11412-1-git-send-email-dehui.sun@mediatek.com>
 <1560252534-11412-2-git-send-email-dehui.sun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560252534-11412-2-git-send-email-dehui.sun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 19:28:53 +0800, Dehui Sun wrote:
> This commit adds mt8183 compatible node in mtk-timer binding document.
> 
> Signed-off-by: Dehui Sun <dehui.sun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

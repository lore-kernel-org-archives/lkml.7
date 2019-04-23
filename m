Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8096C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F8121738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="vhTIMwo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfDWOoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:44:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38002 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfDWOoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:44:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id p14so13760451ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vVdK0v49PgDzk6jAF71uYV8DzfTA8hkwoYIT2UMQ8Cs=;
        b=vhTIMwo0qd3NmRWJvu5iLuqCBUgO06z7jlnTfQrfKPqWwzdN+zeDmLQ5X+KEyghxDu
         0lRkg7q08NT2BZp7jkPZ/FlydGekUv/E/gK6AXpfDfncNKmMtKyRHj3txubK7D4E6DbL
         cBjUbTRqv7/ajt4GMtonxTqwYhnXwclUqvvyydypXwewwefAsAEo536oEfUfM5GAklY7
         5i/mRlfjWJvGDcI+5Y1n9oQjuTPFaQtWJ2FJigtmo1VE8XfA/CRhNboQu++1sE4SoD3G
         dsQWX/Wgvic1dBuvvsVvy8ItDzibx3ue4J/OwsQgHnYSR2Y+lcjEJ9/pbTGHLG7X59tS
         TvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vVdK0v49PgDzk6jAF71uYV8DzfTA8hkwoYIT2UMQ8Cs=;
        b=r+lq4dfI8hDx/gDcU/BPZQ+DzkDSxT2ZvhdOrOkffwj61QGtteUm7MUaedWoTMvFPB
         liklZMEQZJBwXaE3+CiaVSN6TJ4wbbarrpDbL2wqIyl8w96J8G3aTtGW5J11TKO/fxm8
         VUj5ZRUY7oqbPAdqOHvMBgmdPp+c3tXuc3cuTHj7I+zDgvFf4qpcW27aLboJKjhK+1eF
         49cWqyr2jYyTnFRpicsSfgGBrnVUZHgmwb4ZlQc84ucNxgjL7EDrgNpKbPW76OqZxfrX
         0Lt4Ag4TAF6amOpNgQ51pqX5B0p+F7PU5RnNkAyxZPlqrFDylecNlhNiXN8ETQC2ovZ1
         ebkw==
X-Gm-Message-State: APjAAAUtOfyZCrJLWY9AuroKFnaJFiFRCPqFk28qRaVlwY/73k7qCQ7Y
        3gYP04/RFaNTVqUdVCwnfh+d/A==
X-Google-Smtp-Source: APXvYqzxVjpV3l2jJGPXQFfa9YnHZCH72mkjmFrdE89aXpSTFia65TdDAJozqJaMxwcD6LUse6X1ew==
X-Received: by 2002:a2e:219:: with SMTP id 25mr14113073ljc.34.1556030659021;
        Tue, 23 Apr 2019 07:44:19 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.82.73])
        by smtp.gmail.com with ESMTPSA id 77sm3422142ljs.58.2019.04.23.07.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 07:44:17 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] thermal: rcar_gen3_thermal: disable interrupt in
 .remove
To:     Jiada Wang <jiada_wang@mentor.com>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms+renesas@verge.net.au, niklas.soderlund+renesas@ragnatech.se,
        geert+renesas@glider.be, marek.vasut+renesas@gmail.com,
        kuninori.morimoto.gx@renesas.com, hien.dang.eb@renesas.com,
        fabrizio.castro@bp.renesas.com, dien.pham.ry@renesas.com,
        biju.das@bp.renesas.com, erosca@de.adit-jv.com,
        george_davis@mentor.com, joshua_frkuska@mentor.com
References: <20190423141414.24264-1-jiada_wang@mentor.com>
 <20190423141414.24264-3-jiada_wang@mentor.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <2d810fcf-8d31-f07e-d94a-a127127e97cd@cogentembedded.com>
Date:   Tue, 23 Apr 2019 17:44:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190423141414.24264-3-jiada_wang@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23/2019 05:14 PM, Jiada Wang wrote:

> Currently IRQ is remain enabled after .remove, later if device is probed,

   IRQ remains enabled.

> IRQ is requested before .thermal_init, this may cause IRQ function be
> called before device is initialized.
> 
> this patch by disable interrupt in .remove, to ensure irq function

   s/by disable/disables/.

> only be called after device is fully initialized.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
[...]

MBR, Sergei

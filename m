Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DC0C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9530B20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsBDsCgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfFEGes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:34:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38495 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfFEGes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:34:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so11831945pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 23:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j74qjlM9WHB/196pmL6fsOcRFlXhlEU+5GmJo6s7F+8=;
        b=CsBDsCgdKy2tmN10RVUFOkVGzO02MkUhApWGr1QfWdYFte3UwhHpx2ck98TR5XKkR5
         fue5UeS7NgR1wyjCjnq2ij/OuchDoLKWdMoPOItqW4a1iYW+oULbWjInnUd9TMjazq9y
         kmd0UVOF2+aNKxqdt0ceWaw9KBj9w6SpchvHz7QJMpq1s2OBOv3cD19PQ5JqLrMITHWx
         UouHjMaWulH4rbtxw6I36NLKi8P7vKn/cUtwKLdfnWvcg4ZVxaip2visKNUWFrAJGZvt
         Dtyr5o/RdLRtw/aZAIJYjf7lqIF8aAv7nkbPq2/JwyvxL6agQI+vBDrXjO63GRFsDjJU
         HnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j74qjlM9WHB/196pmL6fsOcRFlXhlEU+5GmJo6s7F+8=;
        b=EqYAhFwbTWnHYSbGp31D7tpChWy7xDhZWnIuF5V0Ar53HSh3Zyw/8pLAL07lsOMACb
         k8gfsizT4MDntCb0ejqtYarD4f9nnedPEC9K+2marO4d8Utj40gJYs6HWSpkxHigqltH
         oPlEiLPtahnpPEUZ4Mmt3+Js0ZyitABEXyN5dZNg1m6966cKHTmLuEzNYvNC7NzDv6lM
         +EtzyVpF+EiEEFdKCXcIcvyvbJxYID0xNCGtsMlXnO1fNVlLBvAJm0aWyfMiCF8QcC0p
         shhIiAyKTJoVRNdWz5ojUGX7xFxfm8bXEPm5gYm0dDCQElD7NBJoAf1VpUmNFrL7rJp4
         uJMw==
X-Gm-Message-State: APjAAAUo+mf/D2PAqonALG/UPTSeR2EtJHC6spaK6q5EhVJX/z01iZQ/
        Iv52x8hrTfXOegClhnUg1w0d50xD
X-Google-Smtp-Source: APXvYqzPGv/7y9UAzLcfW+q34ftFwU4lXb9cv68W48k+vuyxMyUPfHuwuxafzZz7Zb1IShN4jQ0FWA==
X-Received: by 2002:a17:90a:ac14:: with SMTP id o20mr14295818pjq.114.1559716487770;
        Tue, 04 Jun 2019 23:34:47 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id q12sm29106397pgs.22.2019.06.04.23.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 23:34:47 -0700 (PDT)
Date:   Wed, 5 Jun 2019 12:04:43 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carmeli Tamir <carmeli.tamir@gmail.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: emxx_udc: fix warning "sum of probable
 bitmasks, consider |"
Message-ID: <20190605063443.GA5248@hari-Inspiron-1545>
References: <20190603185412.GA11183@hari-Inspiron-1545>
 <20190603190457.GA6487@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603190457.GA6487@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:04:57PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 04, 2019 at 12:24:12AM +0530, Hariprasad Kelam wrote:
> > Knowing the fact that operator '|' is faster than '+'.
> > Its better we replace + with | in this case.
> > 
> > Issue reported by coccicheck
> > drivers/staging/emxx_udc/emxx_udc.h:94:34-35: WARNING: sum of probable
> > bitmasks, consider |
> > 
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > ---
> >  drivers/staging/emxx_udc/emxx_udc.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/emxx_udc/emxx_udc.h b/drivers/staging/emxx_udc/emxx_udc.h
> > index b8c3dee..88d6bda 100644
> > --- a/drivers/staging/emxx_udc/emxx_udc.h
> > +++ b/drivers/staging/emxx_udc/emxx_udc.h
> > @@ -91,7 +91,7 @@ int vbus_irq;
> >  #define BIT30		0x40000000
> >  #define BIT31		0x80000000
> 
> All of those BITXX defines should be removed and the "real" BIT(X) macro
> used instead.
Yes will send separate patch  to address this.
> 
> > -#define TEST_FORCE_ENABLE		(BIT18 + BIT16)
> > +#define TEST_FORCE_ENABLE		(BIT18 | BIT16)
> 
> It really doesn't matter, a good compiler will have already turned this
> into a constant value so you really do not know if this is less/faster
> code or not, right?
> 
> Did you look at the output to verify this actually changed anything?
> 
> thanks,
> 
> greg k-h

Ok . Treating this as false postive from coccicheck.

Thanks,
Hariprasad k

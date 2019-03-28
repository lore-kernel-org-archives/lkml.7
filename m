Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC911C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB7520811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC80iElT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfC1RVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:21:48 -0400
Received: from mail-yw1-f51.google.com ([209.85.161.51]:45805 "EHLO
        mail-yw1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfC1RVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:21:47 -0400
Received: by mail-yw1-f51.google.com with SMTP id j128so15358253ywg.12;
        Thu, 28 Mar 2019 10:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+1cenhDZ6abSXQjebrfaSwfIe9wjJQAhX5YTtCWEdcY=;
        b=EC80iElTSyEXU7xII0LntGFXjOioHj7UmSaw1xL6kPzVd+FUtA04oxwhU/eUXj/X3G
         pAgLJ8bcERwtV6obYPI+vMtlCtOBQzE/EQ55xGTfZeNTA1wpcB9mUqcuhZ+PrevuCihH
         J/AYViZTNicD8EabxvQo3qzyvBJPm3uwr7rRZPuJEqOHCWZmsqa9jMU99hZEqgmnzGUz
         sV2Oexb/eCny6OeFLySHd1vm6KsTX21JtYBJiPE4Dwbq0OwoYdNQ4CaUScLVX3EMSSfj
         OqGvwyufY3+arjXhR4S12fvlaahbbXn7mCwoa8cT90sGMDbgn3+P6zjjvfTiwP/gWEPd
         /tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+1cenhDZ6abSXQjebrfaSwfIe9wjJQAhX5YTtCWEdcY=;
        b=FfkuazJbAZxtt0o4hynJwNsnBgSufEkTd9dZGOBrzYDJdgu6CwE7AApRoSf+R1XR9t
         YnEtY16yIeI9NFJaUwhFCjo7KJEYQICkFnPnr16ocUl/dgv7u70whb1UQNS2Iv7ac48u
         0vSzbX0r8cZ4uAOPupO6GZ1r0qcu9cHgbntd3T5nUbgKvZ323aFuZc0H5Pv7g2wpnPqZ
         Ar+SWRmZlefeUl/G5ytSGRcxdxLRS6RBftGt9CQx3uqqnKltwDTQRFC/xMVB9Pv84btP
         JLnJFD6YiwACIoaeSviQFb9ArBk4k8vpKaWeckkDBNbxG0GXm7MZ43LEnwDLRcE9ibCd
         bNWw==
X-Gm-Message-State: APjAAAXBj5AL8y28PK4Wb0XFsCh8tG7y6ks5PDwINeI336cNDgoyVt4/
        bKqoOdGe5GRBTK6oo7DTRSk=
X-Google-Smtp-Source: APXvYqwFaXWgnKszFS8ZBjpQiEm36YWytI+fdo1jjCW8yrJea/RizGedge1pZLNgdOtvPLlNhI28Jw==
X-Received: by 2002:a81:b64f:: with SMTP id h15mr2826265ywk.136.1553793706876;
        Thu, 28 Mar 2019 10:21:46 -0700 (PDT)
Received: from dumbo ([83.137.6.243])
        by smtp.gmail.com with ESMTPSA id v77sm15347553ywv.79.2019.03.28.10.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:21:46 -0700 (PDT)
Date:   Thu, 28 Mar 2019 18:21:41 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] 5.1-rc1: tpm_try_transmit: send(): error -5
Message-ID: <20190328172141.sog6prtldmxulpw7@dumbo>
References: <20190327082115.k35fhxfkk25ekdzw@dumbo>
 <20190328122333.GA7094@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190328122333.GA7094@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 02:23:33PM +0200, Jarkko Sakkinen wrote:
> On Wed, Mar 27, 2019 at 09:21:15AM +0100, Domenico Andreoli wrote:
> > Hi Jarkko,
> >=20
> >   my laptop fails to suspend/hibernate since v5.1-rc1, it worked fine
> > with v4.20 and previous.
> >=20
> > My suspect is on tpm_tis driver, is there anything I can do to understa=
nd
> > what goes wrong here?
> >=20
> > Best regards,
> > Domenico
>=20
> Thank you for reporting this.
>=20
> Can you try if this helps:
>=20
> https://patchwork.kernel.org/patch/10865495/

Yes, it helps. Everything works fine now. Thanks.

>=20
> /Jarkko

Domenico

--=20
3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13

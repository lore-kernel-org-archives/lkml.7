Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AD1C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0386D2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZLbYO+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393566AbfITKcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:32:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25391 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2393529AbfITKcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568975564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fhP+6NrCs/UEtUjZ/ehCLBrFwEaQgimeTuvBc9x1eY0=;
        b=cZLbYO+9mfdw9yPIry72mDtsHVTOlRNQ+kWXnIIkktE1TyjSnRURm2t70Fk9Z5nilXd10G
        INce9d2NbCFsuPgCLIACtStJ1gTQEsAFIjXjAJML0zji6kxjYcsK5T6hF+HKGu4p7L9mcv
        d1iquXOKrKNG94xO8C94OdPcpbUBKMU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-LAWl-ZicMYeHz3xuXwuuWA-1; Fri, 20 Sep 2019 06:32:43 -0400
Received: by mail-ed1-f70.google.com with SMTP id 34so3948142edf.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 03:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wQFzMMOI9IHEdpQikm6nRpd1SNKkoj0WCobwksclq0Y=;
        b=fiHDIv6HIHC51pS5Uaut8GL4J8EZsLUj2YRdVQQwk1eUHlOqF13N1XiRbYyfg5P3cp
         eCxuYJ7ro4d43vS7XHMGTkqScxQXz5PS9jiDKwhpNsINy5rxyNbq0s+BryBvmUMro+wP
         1pEK4/bkIj2UBh+L5OePYCPWpBIAICkRkvQkOWDKyc4IVCs6w7I7Q4FF5vmQIr15cgZa
         A/NYfziG4KpjA+4jEf97XXn9fq7pcXBhFmMtDQbMmAryd2poHBdKIlfBU828E75n1sXy
         AXhYixTjwhx4mNkiw0nU4N38ojlad3IGlLH2+ATSLYP3KgWPz9DQSTOHVQIXpyHQbATF
         BB5w==
X-Gm-Message-State: APjAAAUJ2ejVaSbP1u9lec5Q7135Ze8lLS7wIIObecBSGb5rAD+s+JHv
        G+HneVIEACs8UorRFy+j5RfiiR9kxe4LtEHaWo7D2Frs8gG89IFYXOxBq52MQb0c6gGQfXENOJX
        VK9IBU7QyRcnFO8sVM2jIIURI
X-Received: by 2002:a50:91d8:: with SMTP id h24mr8770062eda.61.1568975562286;
        Fri, 20 Sep 2019 03:32:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxi9K7NP671bCTXdhkhM1E4ekPEY+uAShqKtKrT4/5Jeyl7RIGoVWiOzAx9m92Wz3CgQabPdQ==
X-Received: by 2002:a50:91d8:: with SMTP id h24mr8770056eda.61.1568975562148;
        Fri, 20 Sep 2019 03:32:42 -0700 (PDT)
Received: from localhost.localdomain ([62.140.137.116])
        by smtp.gmail.com with ESMTPSA id e13sm106370eje.52.2019.09.20.03.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 03:32:41 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: i2c-multi-instantiate: Derive the device
 name from parent
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20190920100233.12829-1-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cde45562-af19-77e9-b3c9-7b3eb7dcd459@redhat.com>
Date:   Fri, 20 Sep 2019 12:32:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920100233.12829-1-heikki.krogerus@linux.intel.com>
Content-Language: en-US
X-MC-Unique: LAWl-ZicMYeHz3xuXwuuWA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/20/19 12:02 PM, Heikki Krogerus wrote:
> When naming the new devices, instead of using the ACPI ID in
> the name as base, using the parent device's name. That makes
> it possible to support multiple multi-instance i2c devices
> of the same type in the same system.
>=20
> This fixes an issue seen on some Intel Kaby Lake based
> boards:
>=20
> sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:15.0=
/i2c_designware.0/i2c-0/i2c-INT3515-tps6598x.0'
>=20
> Fixes: 2336dfadfb1e ("platform/x86: i2c-multi-instantiate: Allow to have =
same slaves")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/platform/x86/i2c-multi-instantiate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platf=
orm/x86/i2c-multi-instantiate.c
> index 61fe341a85aa..ea68f6ed66ae 100644
> --- a/drivers/platform/x86/i2c-multi-instantiate.c
> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
> @@ -90,7 +90,7 @@ static int i2c_multi_inst_probe(struct platform_device =
*pdev)
>   =09for (i =3D 0; i < multi->num_clients && inst_data[i].type; i++) {
>   =09=09memset(&board_info, 0, sizeof(board_info));
>   =09=09strlcpy(board_info.type, inst_data[i].type, I2C_NAME_SIZE);
> -=09=09snprintf(name, sizeof(name), "%s-%s.%d", match->id,
> +=09=09snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev),
>   =09=09=09 inst_data[i].type, i);
>   =09=09board_info.dev_name =3D name;
>   =09=09switch (inst_data[i].flags & IRQ_RESOURCE_TYPE) {
>=20


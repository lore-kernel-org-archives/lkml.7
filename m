Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FBBC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 21:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB61215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 21:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8bmurik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgACVr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 16:47:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44843 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728549AbgACVr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 16:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578088045;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=aQ66C15EM+pgbqrVEPhqNK/QPopaJL165JeYQIZUeJw=;
        b=O8bmurikcXHJDhURkNVUcPbznKUIeWWhKXohV6hv0xNnQfUGOUtHzydM/Eq6BaOtdv/jBt
        GBxY2lmQjOvxITvOYWYUu42TRMRIQ/ExTW3hsaEmngTDFs+zZJTW/JsOxiIG/xD9lYRno3
        G9rV1HiRw8WdRnBHYa55eTjd/w3CdME=
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-MrqXTHtqMm29pgFOOTv-vA-1; Fri, 03 Jan 2020 16:47:23 -0500
X-MC-Unique: MrqXTHtqMm29pgFOOTv-vA-1
Received: by mail-yw1-f72.google.com with SMTP id j9so10904481ywg.14
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 13:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=aQ66C15EM+pgbqrVEPhqNK/QPopaJL165JeYQIZUeJw=;
        b=t9incNBBAviTnw9jEfWts3vE0/pH4x2tQWnesDAdqG2v6sp3948d4j5dcRC/qsAvu2
         7nBgb99r+wG3gG7Y/RJD8KZPuTmx4MHwoFabR0E5tUQMfdiVH24pxLEI65AQ6snciFEE
         0ZaWv5gPBUfelHPU7WeTTyvNG9VxS6YsJrsPBRziGisB81/HjxCBhfdnodJjzqT0eJwQ
         iGFoxHC+GdIEcFgzJQVITNuIdSGKG9xxoIuWW1r/JAWwe5bDmaS/52YfRQw2CUXrd7cQ
         GzrcNrZ/HW5wI43M4gcnLvfztchLfNFv8GhzcSO5r2w+El0zq4w4RN9njYZQwnnLICwd
         +YmQ==
X-Gm-Message-State: APjAAAVO0pDrWwz46Y0YjGY7dkeJTBcFcixbtn7UhUOFN0AlwPRYoxeg
        2z9xCKVJe+sKQwpItZpqlhsE4diiwt48MEzGSDk1IL+wxSf/D1K1LpUxB7hI8597rYLZ4eQMGP/
        T19KQ1c3JsKiY9ob05jmFL/2c
X-Received: by 2002:a81:98b:: with SMTP id 133mr64946274ywj.387.1578088043348;
        Fri, 03 Jan 2020 13:47:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwv/q4jZ5mihtaQmAWvF5KH4xP7n1jA76SqQP/5d+Cz8w7XkIwzVRIqbdPsV0pMGBPXo+6N6A==
X-Received: by 2002:a81:98b:: with SMTP id 133mr64946251ywj.387.1578088043065;
        Fri, 03 Jan 2020 13:47:23 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id q189sm24069007ywb.15.2020.01.03.13.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 13:47:22 -0800 (PST)
Date:   Fri, 3 Jan 2020 14:47:20 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Christian Bundy <christianbundy@fraction.io>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
Message-ID: <20200103214720.nf2ahcpk3t2d7lua@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Christian Bundy <christianbundy@fraction.io>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
 <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
 <20191228151526.GA6971@linux.intel.com>
 <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
 <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
 <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
 <20191231010256.kymv4shwmx5jcmey@cantor>
 <20191231155944.GA4790@linux.intel.com>
 <be07a1e4-c290-4185-8c23-d97050279564@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <be07a1e4-c290-4185-8c23-d97050279564@www.fastmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Dec 31 19, Christian Bundy wrote:
>> Christian, were you having any issues with interrupts? You system was going
>> into this code as well.
>
>Unfortunately I'm now unable to test, sorry for the trouble. I replaced my BIOS
>with UEFI firmware and the problem has disappeared. Please let me know if there
>is anything else I can do to help.
>
>Christian
>

That is interesting. Is the tpm functioning, or did the firmware change disable it?
Is there any output from 'dmesg | grep -i tpm' or anything in /sys/class/tpm/ ?


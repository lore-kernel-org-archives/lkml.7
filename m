Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B7BC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744BE20872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQwHYwf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfI0Nwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:52:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45040 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfI0Nwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:52:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id i14so3520691pgt.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 06:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xKnp2oN+GIDBNlqzRwzOgOukBfsDzIPtFvmkMqz4BZU=;
        b=PQwHYwf+Db4Z/47P+2jB8WO/IBykjCmYl72uF7jtzkqixwj98JqKXv0vGDEgTkzQKg
         vqtuXbzOw/DRw+Evn8zxcV8dQRp0iUH3IDlfEMkjc4CyeWAq1bFBUdKsmiz5ltNWM4tc
         Vf6sqmpMELVIQO9lCYQApMG1T+WbEqQIHWMsJK5fX0Ozru+2JMcWSH1CslbXZdh1h4Ud
         9Dn7GmML08Vwoc+x96BnMSpTnH4dtSzncXcEVLOo97cvMkfBeX+XDAjzByeFmRy3Udje
         MrQ5eHA1gZ8zhBlHCCUMHqfOvXRLQ+t+CpIHGGA/mpmtOtF3nr/u7CNbGhNDUSjlD9gv
         ETWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xKnp2oN+GIDBNlqzRwzOgOukBfsDzIPtFvmkMqz4BZU=;
        b=aMyygPHoH1Zg6kLcVva2EBpQhp25fdXv88JsNCZRNpACJZ2oF2jLOhIJf661Oi/yLb
         uGdPVPz4CjeSacTd97ulSlSyDogVrc9rpzbwBHrynyIgtfMn6xMedjWmHQ61+39jp4bc
         JypKbfe69lmBGVLAr39GsB/0HCo5nH/WLCFzu5SUJ4CSS4W/eoAh3qtX45qaEYHhNVin
         EevPum/xnr8dEcm23bWT5cCjvbBjyGAFyaKXLtRMt/9dW1gZVyV28TmzuZPzb+UgIGce
         wjR4HXRhch+rkaRj8kPsG8xP3DlH6eNMD1tDIg+fGI0/QFGKiHY1tBDDPZsaNQaiiq+w
         sYew==
X-Gm-Message-State: APjAAAVlpmJO65Er5b82Q4Q4mei77grSUJ+0BPyusXeSAhWddv+JfNEu
        yYBHRZsV2NtIhj9nAfP9GwTgqXgO
X-Google-Smtp-Source: APXvYqyIm/zE9EfglzfUJfbocXZEwwEISsc0yuQAqtqM0ki0lqDYuU9Eok9PJkV5WMJFyKzTt/dFNw==
X-Received: by 2002:a63:1d0e:: with SMTP id d14mr9433929pgd.324.1569592361368;
        Fri, 27 Sep 2019 06:52:41 -0700 (PDT)
Received: from ArchLinux ([103.231.90.172])
        by smtp.gmail.com with ESMTPSA id 192sm2926063pfb.110.2019.09.27.06.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 06:52:40 -0700 (PDT)
Date:   Fri, 27 Sep 2019 19:22:28 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reap out the dead mutt config links
Message-ID: <20190927135228.GA1452@ArchLinux>
References: <20190927054004.GA17257@Gentoo>
 <20190927013827.65860ac2@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20190927013827.65860ac2@lwn.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 01:38 Fri 27 Sep 2019, Jonathan Corbet wrote:
>On Fri, 27 Sep 2019 11:10:13 +0530
>Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  Documentation/process/email-clients.rst | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
>> index 5273d06c8ff6..1f920d445a8b 100644
>> --- a/Documentation/process/email-clients.rst
>> +++ b/Documentation/process/email-clients.rst
>>
>> -The Mutt docs have lots more information:
>> -
>> -    http://dev.mutt.org/trac/wiki/UseCases/Gmail
>> -
>> -    http://dev.mutt.org/doc/manual.html
>>
>I'm all for the removal of dead links.  But...can you please resubmit the
>patch with a proper changelog saying why this change is being made?
>
>For extra credit, you could try instead to replace them with current
>links, assuming such things exist.
>
>Thanks,
>
>jon

Sure Jon. I will try to find out the url ,if that available and give
back on changelog along with explanation of why we want to remove that.

BTW , I have sent another mail stating that,before sending this
patch,hope you got it. ..but I will put that in the
next patch.

Thanks,
Bhaskar

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl2OFBgACgkQsjqdtxFL
KRXQ0Af/UYcZpHcG6iRosgc2sMBPu2PaRryhAm0bWVXFiPfIknXYdCTa2YJk0e7t
+/oa7f1exYXr0yU18pjJ3fph3qdYaCJi2j0trIG9uYlm+hpFLe9JRM8uxoPG8I58
B+WhcUX4VKyWEYyWiRBnoA8jafBKFjm88Z0r44ApUUWdg6wWuz+0NokXQ1ZSCsNz
UYtgMSoHC/ag8D+L5G+F2U8NCZ6A6X8QWOP45Ps7QYzMemJzL500YjN4xxq6nhMD
RWawaOjwTJbDNpZxwRAKBy1zEYXcmHGoBi/52PCwAfWPFdrvgrBPuyivIWAXk2x6
yspP2LyewgpAszOPijuUUf/Znq2HDw==
=SHqU
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

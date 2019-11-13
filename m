Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B28AC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4DD206CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573678216;
	bh=Ql3fZa5rjGs7bJMRPqP+fBp7TGA4vnJttL2bmp5cfp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UABz5LyiQWiAek01SQBVEfuVeO0HCCpXdcV4qJDpD2Vm7Rq49ieHlfkFays2ibcRV
	 u3Esxmp2JT4jMrNzJB+AZ8sOLxUETPp215O+zWDEBXf9ANck0EgXqYbe21548xLbub
	 8DbHgmedntYOi8uQ9ZcOxxmtKyj/AMgXZ8J2mbDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfKMUuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 15:50:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46343 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMUuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 15:50:13 -0500
Received: by mail-pl1-f196.google.com with SMTP id l4so1550231plt.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 12:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YgE8GLdWFRrNduFilK05nhw+7cZeX1cpxR2N/wuTFX4=;
        b=m16O6WDgRnJblyl5k+V2Jt0QIK5SUhKRrn9iptcLY7x7fhv6lhM/HWlGKSGBkEuHbI
         ZJL5etjrd/zDtlh2gWvXS6Npy4Zu3xzKj45S61gFzomFsxBXfDI1A1FgRpKFVLwk9WDg
         OZEoPJfrI/4iqdk6A3zfgawR65bKmkdfSmNn6MrGgiafPC+LfZaPrPU5+OSo7RMnDRMD
         RlNCLF7b2xIDXK6fztzP/deFJV/3zXiRyq32RVLmquUmaGvXFrKqZDM6WsTosbPbi5dl
         7jx9tLAAMvq+MszUS5FLqf7a0Rz6lhelMuXG54iPwDwwL698Z7ewt6fwE7Ky6jfiv1cY
         mXJA==
X-Gm-Message-State: APjAAAXIvS+tWcmAOHLlrXk2k7Dtytpz8n8cMZv25KR+CXD744AJWWPs
        BFuz3CqTc+O3ikbEKpmacf/ylm3d
X-Google-Smtp-Source: APXvYqzcy4vcwh2whp5snayHmR1i0yy6l2QEz0WLFeJ7GQf6KN0AvGdbSJ7SaBEIKNMSk/rgwnXxqg==
X-Received: by 2002:a17:902:24b:: with SMTP id 69mr5648838plc.203.1573678212948;
        Wed, 13 Nov 2019 12:50:12 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id w62sm4464327pfb.15.2019.11.13.12.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 12:50:11 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C065C403DC; Wed, 13 Nov 2019 20:50:10 +0000 (UTC)
Date:   Wed, 13 Nov 2019 20:50:10 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Drew DeVault <sir@cmpwn.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        " Rafael J. Wysocki" <rafael@kernel.org>,
        ~sircmpwn/public-inbox@lists.sr.ht
Subject: Re: [PATCH v2] firmware loader: log path to loaded firmwares
Message-ID: <20191113205010.GY11244@42.do-not-panic.com>
References: <20191103180646.34880-1-sir@cmpwn.com>
 <20191113005628.GT11244@42.do-not-panic.com>
 <robbat2-20191113T195158-869302266Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <robbat2-20191113T195158-869302266Z@orbis-terrarum.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2019 at 08:19:07PM +0000, Robin H. Johnson wrote:
> I have two uses cases overall:
> - log so you know exactly when it's loaded successfully (great if
>   loading a firmware causes your system to lock up a few seconds later)

Then you can change the driver to confirm this, not impose every driver
to do the same.

> - at some point in the future, being able to query what firmware was
>   loaded in the past, and esp. exactly what version/data was in that
>   firmware file.

Firmware data is opaque to the firmware loader, as such details to
extract generic information about firmware details can only be done
by the driver, which could decode the firmware information. Many
drivers print these details themselves already, if they want it.

A generic interface to let us query *all* devices and currently loaded
firmware through the firmware loader would only be possible today for
firmware which requests (the default) caching of firmware upon
suspend/resume given that we keep the device / firmware name pair
around prior to suspend. For those devices it could be possible to
extend the firmware loader with a driver callback which can extract
firmware details in a generic codified way. To support *all* drivers
though, in a more clean way for this, a separate but similar list
could be kept which enables one to do this. Such items would be
torn down upon driver removal. But that would then be an opt-in
new mechanism.

  Luis

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEENnNq2KuOejlQLZofziMdCjCSiKcFAl3MbHsACgkQziMdCjCS
iKd3Nw//RxzcY2Mjyw2f+UtCBV8rIRfl5oyu4HTDDyy0DnCjL0zBQtWqIdTkP4oI
jYd6QnYDRO929sBkagad6c5tWTKd9kup8cpyrpZsRZ/FtYoo/0QC/Jyww1pea2gJ
J/aKwHpBti4lKTz5dwqWM5Vh2EVyMhQmNeMYQiXc03FhGDaFa6RRIjdkWsTQdfjK
rIIj2dWiquzVwUadro4TfLPU2ZLd06vBwG7dO1FSd7IPlFMxslz+uyH2udND2NTf
hEZXonNrgoDm6nfv8ZrQWRVQdb2efg5d2K5EAWS2HWz6dzemL7FFJaSxtKf9Gbsi
c4cdpWGKBKsQmGSG7+Cylu2W0qQvYFzYlKVb37s8eozWPRfQPh0P9KY/QHqrPXtv
avQe72l1uht70/LwBP7Q8BT1UqberV/waqqY5xLRjyntOkUnUbgyf3ztUMGZTvTj
YlBVil3fpLzWtgIL527toPD+49ntQ1c0+sxryvlUg8LfWm4VxmT4aJKfIYMLIvbR
49qy/ouUqmz4iL3h0KplqEVnVvTHRdbY4DZ0DOfcT2DRc4sCjqjKDJ0odrskuNDf
rHnTqjU0QasgMOeIhXQLoiUK7wr1fWJZ4/JIet2sewi9UNPhEvPMtQLC7TzXppfF
7fj2/ZxjdKh1Gxe+KDm2M0omMj4bqJJJMny4da+yftmBY7fzJqk=
=sLKK
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

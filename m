Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A1FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED4E20700
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExFZknmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbfJVO30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:29:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27060 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727582AbfJVO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571754564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99x+P3m9acVw3MrQAWw2EOvH80A/uxpSA9gp5a6gHE4=;
        b=ExFZknmAUYAUxQyHN3iAvjQHEOQIRqpcaTuYAn5fEBpUfPTBUpn2/K99+jQZB4HEMXLReT
        nSPA3EjQOC3EreZ9GSKUXq77j7qX7opkyujAsIUhQh4Ds6cAowndd+55gt2C1fz5V7gYI4
        c1ueDmUW0DhMzuMI5VvuytFhWsraK14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-6S1jDIpfO_a0u_OZuqNhHg-1; Tue, 22 Oct 2019 10:29:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC5E05E4;
        Tue, 22 Oct 2019 14:29:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-200.phx2.redhat.com [10.3.117.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3B645C1D4;
        Tue, 22 Oct 2019 14:29:13 +0000 (UTC)
Subject: Re: [PATCH] ipmi: Don't allow device module unload when in use
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
References: <20191014134141.GA25427@t560>
 <20191014154632.11103-1-minyard@acm.org>
From:   Tony Camuso <tcamuso@redhat.com>
Message-ID: <28065598-c638-07eb-d966-0e85ce62c37f@redhat.com>
Date:   Tue, 22 Oct 2019 10:29:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191014154632.11103-1-minyard@acm.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 6S1jDIpfO_a0u_OZuqNhHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corey,

Testing shows that this patch works as expected.

Regards,
Tony


On 10/14/19 11:46 AM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> If something has the IPMI driver open, don't allow the device
> module to be unloaded.  Before it would unload and the user would
> get errors on use.
>=20
> This change is made on user request, and it makes it consistent
> with the I2C driver, which has the same behavior.
>=20
> It does change things a little bit with respect to kernel users.
> If the ACPI or IPMI watchdog (or any other kernel user) has
> created a user, then the device module cannot be unloaded.  Before
> it could be unloaded,
>=20
> This does not affect hot-plug.  If the device goes away (it's on
> something removable that is removed or is hot-removed via sysfs)
> then it still behaves as it did before.
>=20
> Reported-by: tony camuso <tcamuso@redhat.com>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
> Tony, here is a suggested change for this.  Can you look it over and
> see if it looks ok?
>=20
> Thanks,
>=20
> -corey
>=20
>   drivers/char/ipmi/ipmi_msghandler.c | 23 ++++++++++++++++-------
>   include/linux/ipmi_smi.h            | 12 ++++++++----
>   2 files changed, 24 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi=
_msghandler.c
> index 2aab80e19ae0..15680de18625 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -448,6 +448,8 @@ enum ipmi_stat_indexes {
>  =20
>   #define IPMI_IPMB_NUM_SEQ=0964
>   struct ipmi_smi {
> +=09struct module *owner;
> +
>   =09/* What interface number are we? */
>   =09int intf_num;
>  =20
> @@ -1220,6 +1222,11 @@ int ipmi_create_user(unsigned int          if_num,
>   =09if (rv)
>   =09=09goto out_kfree;
>  =20
> +=09if (!try_module_get(intf->owner)) {
> +=09=09rv =3D -ENODEV;
> +=09=09goto out_kfree;
> +=09}
> +=09
>   =09/* Note that each existing user holds a refcount to the interface. *=
/
>   =09kref_get(&intf->refcount);
>  =20
> @@ -1349,6 +1356,7 @@ static void _ipmi_destroy_user(struct ipmi_user *us=
er)
>   =09}
>  =20
>   =09kref_put(&intf->refcount, intf_free);
> +=09module_put(intf->owner);
>   }
>  =20
>   int ipmi_destroy_user(struct ipmi_user *user)
> @@ -2459,7 +2467,7 @@ static int __get_device_id(struct ipmi_smi *intf, s=
truct bmc_device *bmc)
>    * been recently fetched, this will just use the cached data.  Otherwis=
e
>    * it will run a new fetch.
>    *
> - * Except for the first time this is called (in ipmi_register_smi()),
> + * Except for the first time this is called (in ipmi_add_smi()),
>    * this will always return good data;
>    */
>   static int __bmc_get_device_id(struct ipmi_smi *intf, struct bmc_device=
 *bmc,
> @@ -3377,10 +3385,11 @@ static void redo_bmc_reg(struct work_struct *work=
)
>   =09kref_put(&intf->refcount, intf_free);
>   }
>  =20
> -int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
> -=09=09      void=09=09       *send_info,
> -=09=09      struct device            *si_dev,
> -=09=09      unsigned char            slave_addr)
> +int ipmi_add_smi(struct module         *owner,
> +=09=09 const struct ipmi_smi_handlers *handlers,
> +=09=09 void=09=09       *send_info,
> +=09=09 struct device         *si_dev,
> +=09=09 unsigned char         slave_addr)
>   {
>   =09int              i, j;
>   =09int              rv;
> @@ -3406,7 +3415,7 @@ int ipmi_register_smi(const struct ipmi_smi_handler=
s *handlers,
>   =09=09return rv;
>   =09}
>  =20
> -
> +=09intf->owner =3D owner;
>   =09intf->bmc =3D &intf->tmp_bmc;
>   =09INIT_LIST_HEAD(&intf->bmc->intfs);
>   =09mutex_init(&intf->bmc->dyn_mutex);
> @@ -3514,7 +3523,7 @@ int ipmi_register_smi(const struct ipmi_smi_handler=
s *handlers,
>  =20
>   =09return rv;
>   }
> -EXPORT_SYMBOL(ipmi_register_smi);
> +EXPORT_SYMBOL(ipmi_add_smi);
>  =20
>   static void deliver_smi_err_response(struct ipmi_smi *intf,
>   =09=09=09=09     struct ipmi_smi_msg *msg,
> diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
> index 4dc66157d872..deec18b8944a 100644
> --- a/include/linux/ipmi_smi.h
> +++ b/include/linux/ipmi_smi.h
> @@ -224,10 +224,14 @@ static inline int ipmi_demangle_device_id(uint8_t n=
etfn, uint8_t cmd,
>    * is called, and the lower layer must get the interface from that
>    * call.
>    */
> -int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
> -=09=09      void                     *send_info,
> -=09=09      struct device            *dev,
> -=09=09      unsigned char            slave_addr);
> +int ipmi_add_smi(struct module            *owner,
> +=09=09 const struct ipmi_smi_handlers *handlers,
> +=09=09 void                     *send_info,
> +=09=09 struct device            *dev,
> +=09=09 unsigned char            slave_addr);
> +
> +#define ipmi_register_smi(handlers, send_info, dev, slave_addr) \
> +=09ipmi_add_smi(THIS_MODULE, handlers, send_info, dev, slave_addr)
>  =20
>   /*
>    * Remove a low-level interface from the IPMI driver.  This will
>=20


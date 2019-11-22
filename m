Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AD7C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318F82071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 12:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="pq4jGsoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfKVMAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 07:00:05 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:9186 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfKVMAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 07:00:04 -0500
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Nov 2019 06:59:59 EST
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id D9653411CA;
        Fri, 22 Nov 2019 12:59:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1574423995; x=1576238396; bh=tu1D/CAtnjjw5uYzjN3UTiTO8tfWg3V0PXI
        pYePePag=; b=pq4jGsoSqEW1g+fS+9sTLZurLaEkIGTgXiFtZC2gE7d7nEJIvgO
        Hd2E7TqhEVatNAbmmEx00k1FlbVtLMXF/8uHar4sbzQVg/dZ2BnZX081gF1m9KBe
        gwaJrB7KCGsZ0/zOiRwJYzHq1UNZgvhY9OpWHhLnmENM/04QhaiCNjUfOAM6i5GI
        k3wcXQ5S1K7XgMVBeBxt7k8AYE6F1X47pn5jHbui8mRHaiurq36YDZvUI9e51j/N
        RlhE84GUvGProFho8pnPYu2zSPVYZsl2F4N3TGUF/HHxOX46W0NJdVjxMSWLgOT9
        sRBYpevMsKPJRsy88YeYsN6Ov9zLlPUFUxIQrhRwbaBd3kwIT9BJSRdmlHIjfo4Q
        NiUwWcqkBmcoo9eEBQ3J2jQEgCyFuCIMx29/DvqK7BIWagJ4ZL+nGvUfZ02nG1Ho
        i55X+B3CiyR3hxKd/sKPk74glaLvkE0TaEynoqs+Ne5W2GHyxI0zkH7qt5Ls9lsm
        stEfG6O13MKBiKZ2IFEAhLwSJtIKOlAgtqSt4Ze1infLF3c9FQNRg8XcC559vEHg
        +Av237SqnnKMGYzvGi5GEjokzqow9itdRVtYaS1wMbztsGZy9+rWuuL65h0MAi2M
        qDq1R4mZvjRHNeVnliH3o697yklkmOWRdIHdTLXGcvi0/b8Bc8Gygxnw=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HoX86ploM2X6; Fri, 22 Nov 2019 12:59:55 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 769F4411BE;
        Fri, 22 Nov 2019 12:59:55 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 0C550161C;
        Fri, 22 Nov 2019 12:59:55 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Pascal Terjan <pterjan@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete obsolete magic constants from documentation
Date:   Fri, 22 Nov 2019 12:59:53 +0100
Message-ID: <2462409.y8SAkfQYN6@harkonnen>
In-Reply-To: <20191121191536.186051-1-pterjan@google.com>
References: <20191121191536.186051-1-pterjan@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>

On Thursday, November 21, 2019 8:15:36 PM CET Pascal Terjan wrote:
> Those no longer appear in the code.
> I have some more patches to cleanup some of them from the code but this
> is an easy first step.
>=20
> Signed-off-by: Pascal Terjan <pterjan@google.com>
> ---
>  Documentation/process/magic-number.rst        | 44 -------------------
>  .../it_IT/process/magic-number.rst            | 44 -------------------
>  .../zh_CN/process/magic-number.rst            | 44 -------------------
>  3 files changed, 132 deletions(-)
>=20
> diff --git a/Documentation/process/magic-number.rst
> b/Documentation/process/magic-number.rst index eee9b44553b3..16f6a4a97c1e
> 100644
> --- a/Documentation/process/magic-number.rst
> +++ b/Documentation/process/magic-number.rst
> @@ -70,77 +70,34 @@ Magic Name            Number           Structure     =
  =20
>        File =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D PG_MAGIC            =
  'P'      =20
>       pg_{read,write}_hdr      ``include/linux/pg.h`` CMAGIC             =
 =20
> 0x0111           user                     ``include/linux/a.out.h``
> -MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel          =20
> ``drivers/net/mkiss.h`` HDLC_MAGIC            0x239e           n_hdlc    =
 =20
>             ``drivers/char/n_hdlc.c`` APM_BIOS_MAGIC        0x4101       =
 =20
>  apm_user                 ``arch/x86/kernel/apm_32.c`` CYCLADES_MAGIC    =
 =20
>  0x4359           cyclades_port            ``include/linux/cyclades.h``
> -DB_MAGIC              0x4442           fc_info                =20
> ``drivers/net/iph5526_novram.c`` -DL_MAGIC              0x444d         =20
> fc_info                  ``drivers/net/iph5526_novram.c`` FASYNC_MAGIC   =
 =20
>     0x4601           fasync_struct            ``include/linux/fs.h``
> -FF_MAGIC              0x4646           fc_info                =20
> ``drivers/net/iph5526_novram.c`` ISICOM_MAGIC          0x4d54         =20
> isi_port                 ``include/linux/isicom.h`` -PTY_MAGIC           =
=20
> 0x5001                                    ``drivers/char/pty.c`` -PPP_MAG=
IC
>             0x5002           ppp                    =20
> ``include/linux/if_pppvar.h`` -SSTATE_MAGIC          0x5302         =20
> serial_state             ``include/linux/serial.h`` SLIP_MAGIC          =
=20
> 0x5302           slip                     ``drivers/net/slip.h``
> -STRIP_MAGIC           0x5303           strip                  =20
> ``drivers/net/strip.c`` X25_ASY_MAGIC         0x5303           x25_asy   =
 =20
>             ``drivers/net/x25_asy.h`` -SIXPACK_MAGIC         0x5304      =
 =20
>   sixpack                  ``drivers/net/hamradio/6pack.h`` -AX25_MAGIC  =
 =20
>        0x5316           ax_disp                  ``drivers/net/mkiss.h``
> TTY_MAGIC             0x5401           tty_struct             =20
> ``include/linux/tty.h`` MGSL_MAGIC            0x5401           mgsl_info =
 =20
>             ``drivers/char/synclink.c`` TTY_DRIVER_MAGIC      0x5402     =
 =20
>    tty_driver               ``include/linux/tty_driver.h`` MGSLPC_MAGIC  =
 =20
>      0x5402           mgslpc_info            =20
> ``drivers/char/pcmcia/synclink_cs.c`` TTY_LDISC_MAGIC       0x5403       =
 =20
>  tty_ldisc                ``include/linux/tty_ldisc.h`` -USB_SERIAL_MAGIC=
 =20
>    0x6702           usb_serial             =20
> ``drivers/usb/serial/usb-serial.h`` FULL_DUPLEX_MAGIC     0x6969         =
 =20
>                         ``drivers/net/ethernet/dec/tulip/de2104x.c``
> -USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth          =20
> ``drivers/usb/class/bluetty.c`` RFCOMM_TTY_MAGIC      0x6d02             =
 =20
>                     ``net/bluetooth/rfcomm/tty.c`` -USB_SERIAL_PORT_MAGIC
> 0x7301           usb_serial_port        =20
> ``drivers/usb/serial/usb-serial.h`` CG_MAGIC              0x00090255     =
=20
> ufs_cylinder_group       ``include/linux/ufs_fs.h`` RPORT_MAGIC         =
=20
> 0x00525001       r_port                   ``drivers/char/rocket_int.h``
> -LSEMAGIC              0x05091998       lse                    =20
> ``drivers/fc4/fc.c`` GDTIOCTL_MAGIC        0x06030f07       gdth_iowr_str=
 =20
>          ``drivers/scsi/gdth_ioctl.h`` RIEBL_MAGIC           0x09051990  =
 =20
>                            ``drivers/net/atarilance.c`` NBD_REQUEST_MAGIC=
 =20
>   0x12560953       nbd_request              ``include/linux/nbd.h``
> -RED_MAGIC2            0x170fc2a5       (any)                  =20
> ``mm/slab.c`` BAYCOM_MAGIC          0x19730510       baycom_state        =
 =20
>   ``drivers/net/baycom_epp.c`` -ISDN_X25IFACE_MAGIC   0x1e75a2b9     =20
> isdn_x25iface_proto_data ``drivers/isdn/isdn_x25iface.h`` -ECP_MAGIC     =
 =20
>      0x21504345       cdkecpsig                ``include/linux/cdk.h``
> -LSOMAGIC              0x27091997       lso                    =20
> ``drivers/fc4/fc.c`` -LSMAGIC               0x2a3b4d2a       ls          =
 =20
>           ``drivers/fc4/fc.c`` -WANPIPE_MAGIC         0x414C4453     =20
> sdla_{dump,exec}         ``include/linux/wanpipe.h`` -CS_CARD_MAGIC      =
 =20
> 0x43525553       cs_card                  ``sound/oss/cs46xx.c``
> -LABELCL_MAGIC         0x4857434c       labelcl_info_s         =20
> ``include/asm/ia64/sn/labelcl.h`` -ISDN_ASYNC_MAGIC      0x49344C01     =
=20
> modem_info               ``include/linux/isdn.h`` -CTC_ASYNC_MAGIC     =20
> 0x49344C01       ctc_tty_info             ``drivers/s390/net/ctctty.c``
> -ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s       =20
> ``drivers/isdn/i4l/isdn_net_lib.h`` SAVEKMSG_MAGIC2       0x4B4D5347     =
=20
> savekmsg                 ``arch/*/amiga/config.c`` -CS_STATE_MAGIC      =
=20
> 0x4c4f4749       cs_state                 ``sound/oss/cs46xx.c``
> -SLAB_C_MAGIC          0x4f17a36d       kmem_cache             =20
> ``mm/slab.c`` COW_MAGIC             0x4f4f4f4d       cow_header_v1       =
 =20
>   ``arch/um/drivers/ubd_user.c`` -I810_CARD_MAGIC       0x5072696E     =20
> i810_card                ``sound/oss/i810_audio.c`` -TRIDENT_CARD_MAGIC  =
=20
> 0x5072696E       trident_card             ``sound/oss/trident.c``
> -ROUTER_MAGIC          0x524d4157       wan_device               [in
> ``wanrouter.h`` pre 3.9] SAVEKMSG_MAGIC1       0x53415645       savekmsg =
 =20
>              ``arch/*/amiga/config.c`` GDA_MAGIC             0x58464552  =
 =20
>   gda                      ``arch/mips/include/asm/sn/gda.h`` -RED_MAGIC1=
 =20
>          0x5a2cf071       (any)                    ``mm/slab.c``
> EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev              =20
> ``drivers/atm/lanai.c`` HDLCDRV_MAGIC         0x5ac6e778     =20
> hdlcdrv_state            ``include/linux/hdlcdrv.h`` -PCXX_MAGIC         =
 =20
> 0x5c6df104       channel                  ``drivers/char/pcxx.h`` KV_MAGI=
C=20
>             0x5f4b565f       kernel_vars_s          =20
> ``arch/mips/include/asm/sn/klkernvars.h`` -I810_STATE_MAGIC      0x636573=
73
>       i810_state               ``sound/oss/i810_audio.c``
> -TRIDENT_STATE_MAGIC   0x63657373       trient_state           =20
> ``sound/oss/trident.c`` -M3_CARD_MAGIC         0x646e6f50       m3_card  =
 =20
>              ``sound/oss/maestro3.c`` FW_HEADER_MAGIC       0x65726F66   =
 =20
>  fw_header                ``drivers/atm/fore200e.h`` -SLOT_MAGIC         =
 =20
> 0x67267321       slot                     ``drivers/hotplug/cpqphp.h``
> -SLOT_MAGIC            0x67267322       slot                   =20
> ``drivers/hotplug/acpiphp.h`` -LO_MAGIC              0x68797548     =20
> nbd_device               ``include/linux/nbd.h`` -OPROFILE_MAGIC      =20
> 0x6f70726f       super_block              ``drivers/oprofile/oprofilefs.h=
``
> -M3_STATE_MAGIC        0x734d724d       m3_state               =20
> ``sound/oss/maestro3.c`` -VMALLOC_MAGIC         0x87654320     =20
> snd_alloc_track          ``sound/core/memory.c`` -KMALLOC_MAGIC       =20
> 0x87654321       snd_alloc_track          ``sound/core/memory.c``
> -PWC_MAGIC             0x89DC10AB       pwc_device             =20
> ``drivers/usb/media/pwc.h`` NBD_REPLY_MAGIC       0x96744668     =20
> nbd_reply                ``include/linux/nbd.h`` ENI155_MAGIC        =20
> 0xa54b872d       midway_eprom	        ``drivers/atm/eni.h`` CODA_MAGIC   =
 =20
>       0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h`` @@
> -149,7 +106,6 @@ YAM_MAGIC             0xF10A7654       yam_port         =
 =20
>      ``drivers/net/ha CCB_MAGIC             0xf2691ad2       ccb         =
 =20
>           ``drivers/scsi/ncr53c8xx.c`` QUEUE_MAGIC_FREE      0xf7e1c9a3  =
 =20
>   queue_entry              ``drivers/scsi/arm/queue.c`` QUEUE_MAGIC_USED =
 =20
>   0xf7e1cc33       queue_entry              ``drivers/scsi/arm/queue.c``
> -HTB_CMAGIC            0xFEFAFEF1       htb_class              =20
> ``net/sched/sch_htb.c`` NMI_MAGIC             0x48414d4d455201 nmi_s     =
 =20
>             ``arch/mips/include/asm/sn/nmi.h`` =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> diff --git a/Documentation/translations/it_IT/process/magic-number.rst
> b/Documentation/translations/it_IT/process/magic-number.rst index
> 783e0de314a0..823acaee8805 100644
> --- a/Documentation/translations/it_IT/process/magic-number.rst
> +++ b/Documentation/translations/it_IT/process/magic-number.rst
> @@ -76,77 +76,34 @@ Nome magico           Numero           Struttura     =
  =20
>        File =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D PG_MAGIC            =
  'P'      =20
>       pg_{read,write}_hdr      ``include/linux/pg.h`` CMAGIC             =
 =20
> 0x0111           user                     ``include/linux/a.out.h``
> -MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel          =20
> ``drivers/net/mkiss.h`` HDLC_MAGIC            0x239e           n_hdlc    =
 =20
>             ``drivers/char/n_hdlc.c`` APM_BIOS_MAGIC        0x4101       =
 =20
>  apm_user                 ``arch/x86/kernel/apm_32.c`` CYCLADES_MAGIC    =
 =20
>  0x4359           cyclades_port            ``include/linux/cyclades.h``
> -DB_MAGIC              0x4442           fc_info                =20
> ``drivers/net/iph5526_novram.c`` -DL_MAGIC              0x444d         =20
> fc_info                  ``drivers/net/iph5526_novram.c`` FASYNC_MAGIC   =
 =20
>     0x4601           fasync_struct            ``include/linux/fs.h``
> -FF_MAGIC              0x4646           fc_info                =20
> ``drivers/net/iph5526_novram.c`` ISICOM_MAGIC          0x4d54         =20
> isi_port                 ``include/linux/isicom.h`` -PTY_MAGIC           =
=20
> 0x5001                                    ``drivers/char/pty.c`` -PPP_MAG=
IC
>             0x5002           ppp                    =20
> ``include/linux/if_pppvar.h`` -SSTATE_MAGIC          0x5302         =20
> serial_state             ``include/linux/serial.h`` SLIP_MAGIC          =
=20
> 0x5302           slip                     ``drivers/net/slip.h``
> -STRIP_MAGIC           0x5303           strip                  =20
> ``drivers/net/strip.c`` X25_ASY_MAGIC         0x5303           x25_asy   =
 =20
>             ``drivers/net/x25_asy.h`` -SIXPACK_MAGIC         0x5304      =
 =20
>   sixpack                  ``drivers/net/hamradio/6pack.h`` -AX25_MAGIC  =
 =20
>        0x5316           ax_disp                  ``drivers/net/mkiss.h``
> TTY_MAGIC             0x5401           tty_struct             =20
> ``include/linux/tty.h`` MGSL_MAGIC            0x5401           mgsl_info =
 =20
>             ``drivers/char/synclink.c`` TTY_DRIVER_MAGIC      0x5402     =
 =20
>    tty_driver               ``include/linux/tty_driver.h`` MGSLPC_MAGIC  =
 =20
>      0x5402           mgslpc_info            =20
> ``drivers/char/pcmcia/synclink_cs.c`` TTY_LDISC_MAGIC       0x5403       =
 =20
>  tty_ldisc                ``include/linux/tty_ldisc.h`` -USB_SERIAL_MAGIC=
 =20
>    0x6702           usb_serial             =20
> ``drivers/usb/serial/usb-serial.h`` FULL_DUPLEX_MAGIC     0x6969         =
 =20
>                         ``drivers/net/ethernet/dec/tulip/de2104x.c``
> -USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth          =20
> ``drivers/usb/class/bluetty.c`` RFCOMM_TTY_MAGIC      0x6d02             =
 =20
>                     ``net/bluetooth/rfcomm/tty.c`` -USB_SERIAL_PORT_MAGIC
> 0x7301           usb_serial_port        =20
> ``drivers/usb/serial/usb-serial.h`` CG_MAGIC              0x00090255     =
=20
> ufs_cylinder_group       ``include/linux/ufs_fs.h`` RPORT_MAGIC         =
=20
> 0x00525001       r_port                   ``drivers/char/rocket_int.h``
> -LSEMAGIC              0x05091998       lse                    =20
> ``drivers/fc4/fc.c`` GDTIOCTL_MAGIC        0x06030f07       gdth_iowr_str=
 =20
>          ``drivers/scsi/gdth_ioctl.h`` RIEBL_MAGIC           0x09051990  =
 =20
>                            ``drivers/net/atarilance.c`` NBD_REQUEST_MAGIC=
 =20
>   0x12560953       nbd_request              ``include/linux/nbd.h``
> -RED_MAGIC2            0x170fc2a5       (any)                  =20
> ``mm/slab.c`` BAYCOM_MAGIC          0x19730510       baycom_state        =
 =20
>   ``drivers/net/baycom_epp.c`` -ISDN_X25IFACE_MAGIC   0x1e75a2b9     =20
> isdn_x25iface_proto_data ``drivers/isdn/isdn_x25iface.h`` -ECP_MAGIC     =
 =20
>      0x21504345       cdkecpsig                ``include/linux/cdk.h``
> -LSOMAGIC              0x27091997       lso                    =20
> ``drivers/fc4/fc.c`` -LSMAGIC               0x2a3b4d2a       ls          =
 =20
>           ``drivers/fc4/fc.c`` -WANPIPE_MAGIC         0x414C4453     =20
> sdla_{dump,exec}         ``include/linux/wanpipe.h`` -CS_CARD_MAGIC      =
 =20
> 0x43525553       cs_card                  ``sound/oss/cs46xx.c``
> -LABELCL_MAGIC         0x4857434c       labelcl_info_s         =20
> ``include/asm/ia64/sn/labelcl.h`` -ISDN_ASYNC_MAGIC      0x49344C01     =
=20
> modem_info               ``include/linux/isdn.h`` -CTC_ASYNC_MAGIC     =20
> 0x49344C01       ctc_tty_info             ``drivers/s390/net/ctctty.c``
> -ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s       =20
> ``drivers/isdn/i4l/isdn_net_lib.h`` SAVEKMSG_MAGIC2       0x4B4D5347     =
=20
> savekmsg                 ``arch/*/amiga/config.c`` -CS_STATE_MAGIC      =
=20
> 0x4c4f4749       cs_state                 ``sound/oss/cs46xx.c``
> -SLAB_C_MAGIC          0x4f17a36d       kmem_cache             =20
> ``mm/slab.c`` COW_MAGIC             0x4f4f4f4d       cow_header_v1       =
 =20
>   ``arch/um/drivers/ubd_user.c`` -I810_CARD_MAGIC       0x5072696E     =20
> i810_card                ``sound/oss/i810_audio.c`` -TRIDENT_CARD_MAGIC  =
=20
> 0x5072696E       trident_card             ``sound/oss/trident.c``
> -ROUTER_MAGIC          0x524d4157       wan_device               [in
> ``wanrouter.h`` pre 3.9] SAVEKMSG_MAGIC1       0x53415645       savekmsg =
 =20
>              ``arch/*/amiga/config.c`` GDA_MAGIC             0x58464552  =
 =20
>   gda                      ``arch/mips/include/asm/sn/gda.h`` -RED_MAGIC1=
 =20
>          0x5a2cf071       (any)                    ``mm/slab.c``
> EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev              =20
> ``drivers/atm/lanai.c`` HDLCDRV_MAGIC         0x5ac6e778     =20
> hdlcdrv_state            ``include/linux/hdlcdrv.h`` -PCXX_MAGIC         =
 =20
> 0x5c6df104       channel                  ``drivers/char/pcxx.h`` KV_MAGI=
C=20
>             0x5f4b565f       kernel_vars_s          =20
> ``arch/mips/include/asm/sn/klkernvars.h`` -I810_STATE_MAGIC      0x636573=
73
>       i810_state               ``sound/oss/i810_audio.c``
> -TRIDENT_STATE_MAGIC   0x63657373       trient_state           =20
> ``sound/oss/trident.c`` -M3_CARD_MAGIC         0x646e6f50       m3_card  =
 =20
>              ``sound/oss/maestro3.c`` FW_HEADER_MAGIC       0x65726F66   =
 =20
>  fw_header                ``drivers/atm/fore200e.h`` -SLOT_MAGIC         =
 =20
> 0x67267321       slot                     ``drivers/hotplug/cpqphp.h``
> -SLOT_MAGIC            0x67267322       slot                   =20
> ``drivers/hotplug/acpiphp.h`` -LO_MAGIC              0x68797548     =20
> nbd_device               ``include/linux/nbd.h`` -OPROFILE_MAGIC      =20
> 0x6f70726f       super_block              ``drivers/oprofile/oprofilefs.h=
``
> -M3_STATE_MAGIC        0x734d724d       m3_state               =20
> ``sound/oss/maestro3.c`` -VMALLOC_MAGIC         0x87654320     =20
> snd_alloc_track          ``sound/core/memory.c`` -KMALLOC_MAGIC       =20
> 0x87654321       snd_alloc_track          ``sound/core/memory.c``
> -PWC_MAGIC             0x89DC10AB       pwc_device             =20
> ``drivers/usb/media/pwc.h`` NBD_REPLY_MAGIC       0x96744668     =20
> nbd_reply                ``include/linux/nbd.h`` ENI155_MAGIC        =20
> 0xa54b872d       midway_eprom	        ``drivers/atm/eni.h`` CODA_MAGIC   =
 =20
>       0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h`` @@
> -155,7 +112,6 @@ YAM_MAGIC             0xF10A7654       yam_port         =
 =20
>      ``drivers/net/ha CCB_MAGIC             0xf2691ad2       ccb         =
 =20
>           ``drivers/scsi/ncr53c8xx.c`` QUEUE_MAGIC_FREE      0xf7e1c9a3  =
 =20
>   queue_entry              ``drivers/scsi/arm/queue.c`` QUEUE_MAGIC_USED =
 =20
>   0xf7e1cc33       queue_entry              ``drivers/scsi/arm/queue.c``
> -HTB_CMAGIC            0xFEFAFEF1       htb_class              =20
> ``net/sched/sch_htb.c`` NMI_MAGIC             0x48414d4d455201 nmi_s     =
 =20
>             ``arch/mips/include/asm/sn/nmi.h`` =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> diff --git a/Documentation/translations/zh_CN/process/magic-number.rst
> b/Documentation/translations/zh_CN/process/magic-number.rst index
> e4c225996af0..31669c1cfaa6 100644
> --- a/Documentation/translations/zh_CN/process/magic-number.rst
> +++ b/Documentation/translations/zh_CN/process/magic-number.rst
> @@ -59,77 +59,34 @@ Linux =E9=AD=94=E6=9C=AF=E6=95=B0
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D PG_MAGIC            =
  'P'      =20
>       pg_{read,write}_hdr      ``include/linux/pg.h`` CMAGIC             =
 =20
> 0x0111           user                     ``include/linux/a.out.h``
> -MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel          =20
> ``drivers/net/mkiss.h`` HDLC_MAGIC            0x239e           n_hdlc    =
 =20
>             ``drivers/char/n_hdlc.c`` APM_BIOS_MAGIC        0x4101       =
 =20
>  apm_user                 ``arch/x86/kernel/apm_32.c`` CYCLADES_MAGIC    =
 =20
>  0x4359           cyclades_port            ``include/linux/cyclades.h``
> -DB_MAGIC              0x4442           fc_info                =20
> ``drivers/net/iph5526_novram.c`` -DL_MAGIC              0x444d         =20
> fc_info                  ``drivers/net/iph5526_novram.c`` FASYNC_MAGIC   =
 =20
>     0x4601           fasync_struct            ``include/linux/fs.h``
> -FF_MAGIC              0x4646           fc_info                =20
> ``drivers/net/iph5526_novram.c`` ISICOM_MAGIC          0x4d54         =20
> isi_port                 ``include/linux/isicom.h`` -PTY_MAGIC           =
=20
> 0x5001                                    ``drivers/char/pty.c`` -PPP_MAG=
IC
>             0x5002           ppp                    =20
> ``include/linux/if_pppvar.h`` -SSTATE_MAGIC          0x5302         =20
> serial_state             ``include/linux/serial.h`` SLIP_MAGIC          =
=20
> 0x5302           slip                     ``drivers/net/slip.h``
> -STRIP_MAGIC           0x5303           strip                  =20
> ``drivers/net/strip.c`` X25_ASY_MAGIC         0x5303           x25_asy   =
 =20
>             ``drivers/net/x25_asy.h`` -SIXPACK_MAGIC         0x5304      =
 =20
>   sixpack                  ``drivers/net/hamradio/6pack.h`` -AX25_MAGIC  =
 =20
>        0x5316           ax_disp                  ``drivers/net/mkiss.h``
> TTY_MAGIC             0x5401           tty_struct             =20
> ``include/linux/tty.h`` MGSL_MAGIC            0x5401           mgsl_info =
 =20
>             ``drivers/char/synclink.c`` TTY_DRIVER_MAGIC      0x5402     =
 =20
>    tty_driver               ``include/linux/tty_driver.h`` MGSLPC_MAGIC  =
 =20
>      0x5402           mgslpc_info            =20
> ``drivers/char/pcmcia/synclink_cs.c`` TTY_LDISC_MAGIC       0x5403       =
 =20
>  tty_ldisc                ``include/linux/tty_ldisc.h`` -USB_SERIAL_MAGIC=
 =20
>    0x6702           usb_serial             =20
> ``drivers/usb/serial/usb-serial.h`` FULL_DUPLEX_MAGIC     0x6969         =
 =20
>                         ``drivers/net/ethernet/dec/tulip/de2104x.c``
> -USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth          =20
> ``drivers/usb/class/bluetty.c`` RFCOMM_TTY_MAGIC      0x6d02             =
 =20
>                     ``net/bluetooth/rfcomm/tty.c`` -USB_SERIAL_PORT_MAGIC
> 0x7301           usb_serial_port        =20
> ``drivers/usb/serial/usb-serial.h`` CG_MAGIC              0x00090255     =
=20
> ufs_cylinder_group       ``include/linux/ufs_fs.h`` RPORT_MAGIC         =
=20
> 0x00525001       r_port                   ``drivers/char/rocket_int.h``
> -LSEMAGIC              0x05091998       lse                    =20
> ``drivers/fc4/fc.c`` GDTIOCTL_MAGIC        0x06030f07       gdth_iowr_str=
 =20
>          ``drivers/scsi/gdth_ioctl.h`` RIEBL_MAGIC           0x09051990  =
 =20
>                            ``drivers/net/atarilance.c`` NBD_REQUEST_MAGIC=
 =20
>   0x12560953       nbd_request              ``include/linux/nbd.h``
> -RED_MAGIC2            0x170fc2a5       (any)                  =20
> ``mm/slab.c`` BAYCOM_MAGIC          0x19730510       baycom_state        =
 =20
>   ``drivers/net/baycom_epp.c`` -ISDN_X25IFACE_MAGIC   0x1e75a2b9     =20
> isdn_x25iface_proto_data ``drivers/isdn/isdn_x25iface.h`` -ECP_MAGIC     =
 =20
>      0x21504345       cdkecpsig                ``include/linux/cdk.h``
> -LSOMAGIC              0x27091997       lso                    =20
> ``drivers/fc4/fc.c`` -LSMAGIC               0x2a3b4d2a       ls          =
 =20
>           ``drivers/fc4/fc.c`` -WANPIPE_MAGIC         0x414C4453     =20
> sdla_{dump,exec}         ``include/linux/wanpipe.h`` -CS_CARD_MAGIC      =
 =20
> 0x43525553       cs_card                  ``sound/oss/cs46xx.c``
> -LABELCL_MAGIC         0x4857434c       labelcl_info_s         =20
> ``include/asm/ia64/sn/labelcl.h`` -ISDN_ASYNC_MAGIC      0x49344C01     =
=20
> modem_info               ``include/linux/isdn.h`` -CTC_ASYNC_MAGIC     =20
> 0x49344C01       ctc_tty_info             ``drivers/s390/net/ctctty.c``
> -ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s       =20
> ``drivers/isdn/i4l/isdn_net_lib.h`` SAVEKMSG_MAGIC2       0x4B4D5347     =
=20
> savekmsg                 ``arch/*/amiga/config.c`` -CS_STATE_MAGIC      =
=20
> 0x4c4f4749       cs_state                 ``sound/oss/cs46xx.c``
> -SLAB_C_MAGIC          0x4f17a36d       kmem_cache             =20
> ``mm/slab.c`` COW_MAGIC             0x4f4f4f4d       cow_header_v1       =
 =20
>   ``arch/um/drivers/ubd_user.c`` -I810_CARD_MAGIC       0x5072696E     =20
> i810_card                ``sound/oss/i810_audio.c`` -TRIDENT_CARD_MAGIC  =
=20
> 0x5072696E       trident_card             ``sound/oss/trident.c``
> -ROUTER_MAGIC          0x524d4157       wan_device               [in
> ``wanrouter.h`` pre 3.9] SAVEKMSG_MAGIC1       0x53415645       savekmsg =
 =20
>              ``arch/*/amiga/config.c`` GDA_MAGIC             0x58464552  =
 =20
>   gda                      ``arch/mips/include/asm/sn/gda.h`` -RED_MAGIC1=
 =20
>          0x5a2cf071       (any)                    ``mm/slab.c``
> EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev              =20
> ``drivers/atm/lanai.c`` HDLCDRV_MAGIC         0x5ac6e778     =20
> hdlcdrv_state            ``include/linux/hdlcdrv.h`` -PCXX_MAGIC         =
 =20
> 0x5c6df104       channel                  ``drivers/char/pcxx.h`` KV_MAGI=
C=20
>             0x5f4b565f       kernel_vars_s          =20
> ``arch/mips/include/asm/sn/klkernvars.h`` -I810_STATE_MAGIC      0x636573=
73
>       i810_state               ``sound/oss/i810_audio.c``
> -TRIDENT_STATE_MAGIC   0x63657373       trient_state           =20
> ``sound/oss/trident.c`` -M3_CARD_MAGIC         0x646e6f50       m3_card  =
 =20
>              ``sound/oss/maestro3.c`` FW_HEADER_MAGIC       0x65726F66   =
 =20
>  fw_header                ``drivers/atm/fore200e.h`` -SLOT_MAGIC         =
 =20
> 0x67267321       slot                     ``drivers/hotplug/cpqphp.h``
> -SLOT_MAGIC            0x67267322       slot                   =20
> ``drivers/hotplug/acpiphp.h`` -LO_MAGIC              0x68797548     =20
> nbd_device               ``include/linux/nbd.h`` -OPROFILE_MAGIC      =20
> 0x6f70726f       super_block              ``drivers/oprofile/oprofilefs.h=
``
> -M3_STATE_MAGIC        0x734d724d       m3_state               =20
> ``sound/oss/maestro3.c`` -VMALLOC_MAGIC         0x87654320     =20
> snd_alloc_track          ``sound/core/memory.c`` -KMALLOC_MAGIC       =20
> 0x87654321       snd_alloc_track          ``sound/core/memory.c``
> -PWC_MAGIC             0x89DC10AB       pwc_device             =20
> ``drivers/usb/media/pwc.h`` NBD_REPLY_MAGIC       0x96744668     =20
> nbd_reply                ``include/linux/nbd.h`` ENI155_MAGIC        =20
> 0xa54b872d       midway_eprom	        ``drivers/atm/eni.h`` CODA_MAGIC   =
 =20
>       0xC0DAC0DA       coda_file_info           ``fs/coda/coda_fs_i.h`` @@
> -138,7 +95,6 @@ YAM_MAGIC             0xF10A7654       yam_port          =
 =20
>     ``drivers/net/ha CCB_MAGIC             0xf2691ad2       ccb          =
 =20
>          ``drivers/scsi/ncr53c8xx.c`` QUEUE_MAGIC_FREE      0xf7e1c9a3   =
 =20
>  queue_entry              ``drivers/scsi/arm/queue.c`` QUEUE_MAGIC_USED  =
 =20
>  0xf7e1cc33       queue_entry              ``drivers/scsi/arm/queue.c``
> -HTB_CMAGIC            0xFEFAFEF1       htb_class              =20
> ``net/sched/sch_htb.c`` NMI_MAGIC             0x48414d4d455201 nmi_s     =
 =20
>             ``arch/mips/include/asm/sn/nmi.h`` =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D





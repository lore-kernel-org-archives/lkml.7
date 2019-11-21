Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A67C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6132068E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oT3oSKxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKUTQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:16:15 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:51756 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfKUTQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:16:14 -0500
Received: by mail-wr1-f74.google.com with SMTP id c6so2549891wrm.18
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 11:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=eDo2/2f7aPPdN41/Mi3Ub57qv0NK2Tw/YGVmpzcBB3Q=;
        b=oT3oSKxvQ85Yy8/aAX4epB2qAfkUFfEZ9fnkrnxTaTv5H9mC7H+8XKbCrQObcF9CuH
         noHQ/groSNUxohiFYo7FwUKyOzNV+fsz/NkmBam1b9ETG1m91ULNOU0kL22x0ez8xcOV
         TtI/DeWFRt8eR7dXUo70YNhfb4exIRtFrgGwuaRkqg83F/9BDUZeDauYyqlCR8B12rhh
         yxiG7R/3lTOIILQdWJmunc/2ANbs+judwl7P/3XdK0UIn7v7SYpnRrs5JPiVu7CUOly2
         DIsb5VbOUv7Mu5Zw1iXNjNk3D7dt1zGB2h+tGR0W3foe6UZRcLUxgd7A+rJkuwejnjh7
         m2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=eDo2/2f7aPPdN41/Mi3Ub57qv0NK2Tw/YGVmpzcBB3Q=;
        b=nPoeFat1vTNKJ6bOmcVvRHqCmkduTCWJkrwSsW+FwTagKneu3FxLWoo6aMnEVW+1JO
         7akN/KrVGOJ7JMvyh8xQmkLiLRHYINVkccqsnxEAl4m2YX6sjACDMirUn8PvbSi8NEuT
         xGe+DSY1cJFrjpWwdc7+WvzmxzGOTzCTGEIYoMeJCFxzxavroAESHQ9pkwBv8jrXlLAt
         h7xt/SdI94qNNjdjq4IbrgqA/QZGLRJbAs98cpwCq5zaKLDoKscr+d0/rHv/MWrFmB+B
         LER8EbbgzKTuLFW7HjKkRdC4A8FbrWtcc6D/D6DYtJl7RRxN1Wf0H8+lL8NEmdOvbKbl
         YlHw==
X-Gm-Message-State: APjAAAVoB8+Wn2/LMi3BqLCl2ygeXYuVMDA+snyakxlrioBArYzW6DxT
        qBykkSN55pW7Gh19bIWoubeIq0T9dQxr
X-Google-Smtp-Source: APXvYqxqGfZSF7qNA+ApRtWR49JENzLS1HHeUvL1x9B/Y7Kp3GJSphVPTK6+4DSPvwtr/we7R3De5gD7hr05
X-Received: by 2002:adf:fec5:: with SMTP id q5mr13116805wrs.293.1574363770196;
 Thu, 21 Nov 2019 11:16:10 -0800 (PST)
Date:   Thu, 21 Nov 2019 19:15:36 +0000
Message-Id: <20191121191536.186051-1-pterjan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] Delete obsolete magic constants from documentation
From:   Pascal Terjan <pterjan@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pascal Terjan <pterjan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those no longer appear in the code.
I have some more patches to cleanup some of them from the code but this
is an easy first step.

Signed-off-by: Pascal Terjan <pterjan@google.com>
---
 Documentation/process/magic-number.rst        | 44 -------------------
 .../it_IT/process/magic-number.rst            | 44 -------------------
 .../zh_CN/process/magic-number.rst            | 44 -------------------
 3 files changed, 132 deletions(-)

diff --git a/Documentation/process/magic-number.rst b/Documentation/process=
/magic-number.rst
index eee9b44553b3..16f6a4a97c1e 100644
--- a/Documentation/process/magic-number.rst
+++ b/Documentation/process/magic-number.rst
@@ -70,77 +70,34 @@ Magic Name            Number           Structure       =
         File
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
 CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
-MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/=
net/mkiss.h``
 HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 CYCLADES_MAGIC        0x4359           cyclades_port            ``include/=
linux/cyclades.h``
-DB_MAGIC              0x4442           fc_info                  ``drivers/=
net/iph5526_novram.c``
-DL_MAGIC              0x444d           fc_info                  ``drivers/=
net/iph5526_novram.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
-FF_MAGIC              0x4646           fc_info                  ``drivers/=
net/iph5526_novram.c``
 ISICOM_MAGIC          0x4d54           isi_port                 ``include/=
linux/isicom.h``
-PTY_MAGIC             0x5001                                    ``drivers/=
char/pty.c``
-PPP_MAGIC             0x5002           ppp                      ``include/=
linux/if_pppvar.h``
-SSTATE_MAGIC          0x5302           serial_state             ``include/=
linux/serial.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
-STRIP_MAGIC           0x5303           strip                    ``drivers/=
net/strip.c``
 X25_ASY_MAGIC         0x5303           x25_asy                  ``drivers/=
net/x25_asy.h``
-SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
-AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
 TTY_MAGIC             0x5401           tty_struct               ``include/=
linux/tty.h``
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 TTY_LDISC_MAGIC       0x5403           tty_ldisc                ``include/=
linux/tty_ldisc.h``
-USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/=
usb/serial/usb-serial.h``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
-USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/=
usb/class/bluetty.c``
 RFCOMM_TTY_MAGIC      0x6d02                                    ``net/blue=
tooth/rfcomm/tty.c``
-USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/=
usb/serial/usb-serial.h``
 CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
 RPORT_MAGIC           0x00525001       r_port                   ``drivers/=
char/rocket_int.h``
-LSEMAGIC              0x05091998       lse                      ``drivers/=
fc4/fc.c``
 GDTIOCTL_MAGIC        0x06030f07       gdth_iowr_str            ``drivers/=
scsi/gdth_ioctl.h``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
-RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.=
c``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/=
isdn/isdn_x25iface.h``
-ECP_MAGIC             0x21504345       cdkecpsig                ``include/=
linux/cdk.h``
-LSOMAGIC              0x27091997       lso                      ``drivers/=
fc4/fc.c``
-LSMAGIC               0x2a3b4d2a       ls                       ``drivers/=
fc4/fc.c``
-WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/=
linux/wanpipe.h``
-CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/os=
s/cs46xx.c``
-LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/=
asm/ia64/sn/labelcl.h``
-ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/=
linux/isdn.h``
-CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/=
s390/net/ctctty.c``
-ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/=
isdn/i4l/isdn_net_lib.h``
 SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
-CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/os=
s/cs46xx.c``
-SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.=
c``
 COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
-I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/os=
s/i810_audio.c``
-TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/os=
s/trident.c``
-ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanr=
outer.h`` pre 3.9]
 SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
 GDA_MAGIC             0x58464552       gda                      ``arch/mip=
s/include/asm/sn/gda.h``
-RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.=
c``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-PCXX_MAGIC            0x5c6df104       channel                  ``drivers/=
char/pcxx.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-I810_STATE_MAGIC      0x63657373       i810_state               ``sound/os=
s/i810_audio.c``
-TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/os=
s/trident.c``
-M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/os=
s/maestro3.c``
 FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
-SLOT_MAGIC            0x67267321       slot                     ``drivers/=
hotplug/cpqphp.h``
-SLOT_MAGIC            0x67267322       slot                     ``drivers/=
hotplug/acpiphp.h``
-LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
-OPROFILE_MAGIC        0x6f70726f       super_block              ``drivers/=
oprofile/oprofilefs.h``
-M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/os=
s/maestro3.c``
-VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/co=
re/memory.c``
-KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/co=
re/memory.c``
-PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/=
usb/media/pwc.h``
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
@@ -149,7 +106,6 @@ YAM_MAGIC             0xF10A7654       yam_port        =
         ``drivers/net/ha
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
-HTB_CMAGIC            0xFEFAFEF1       htb_class                ``net/sche=
d/sch_htb.c``
 NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Do=
cumentation/translations/it_IT/process/magic-number.rst
index 783e0de314a0..823acaee8805 100644
--- a/Documentation/translations/it_IT/process/magic-number.rst
+++ b/Documentation/translations/it_IT/process/magic-number.rst
@@ -76,77 +76,34 @@ Nome magico           Numero           Struttura       =
         File
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
 CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
-MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/=
net/mkiss.h``
 HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 CYCLADES_MAGIC        0x4359           cyclades_port            ``include/=
linux/cyclades.h``
-DB_MAGIC              0x4442           fc_info                  ``drivers/=
net/iph5526_novram.c``
-DL_MAGIC              0x444d           fc_info                  ``drivers/=
net/iph5526_novram.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
-FF_MAGIC              0x4646           fc_info                  ``drivers/=
net/iph5526_novram.c``
 ISICOM_MAGIC          0x4d54           isi_port                 ``include/=
linux/isicom.h``
-PTY_MAGIC             0x5001                                    ``drivers/=
char/pty.c``
-PPP_MAGIC             0x5002           ppp                      ``include/=
linux/if_pppvar.h``
-SSTATE_MAGIC          0x5302           serial_state             ``include/=
linux/serial.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
-STRIP_MAGIC           0x5303           strip                    ``drivers/=
net/strip.c``
 X25_ASY_MAGIC         0x5303           x25_asy                  ``drivers/=
net/x25_asy.h``
-SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
-AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
 TTY_MAGIC             0x5401           tty_struct               ``include/=
linux/tty.h``
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 TTY_LDISC_MAGIC       0x5403           tty_ldisc                ``include/=
linux/tty_ldisc.h``
-USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/=
usb/serial/usb-serial.h``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
-USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/=
usb/class/bluetty.c``
 RFCOMM_TTY_MAGIC      0x6d02                                    ``net/blue=
tooth/rfcomm/tty.c``
-USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/=
usb/serial/usb-serial.h``
 CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
 RPORT_MAGIC           0x00525001       r_port                   ``drivers/=
char/rocket_int.h``
-LSEMAGIC              0x05091998       lse                      ``drivers/=
fc4/fc.c``
 GDTIOCTL_MAGIC        0x06030f07       gdth_iowr_str            ``drivers/=
scsi/gdth_ioctl.h``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
-RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.=
c``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/=
isdn/isdn_x25iface.h``
-ECP_MAGIC             0x21504345       cdkecpsig                ``include/=
linux/cdk.h``
-LSOMAGIC              0x27091997       lso                      ``drivers/=
fc4/fc.c``
-LSMAGIC               0x2a3b4d2a       ls                       ``drivers/=
fc4/fc.c``
-WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/=
linux/wanpipe.h``
-CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/os=
s/cs46xx.c``
-LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/=
asm/ia64/sn/labelcl.h``
-ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/=
linux/isdn.h``
-CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/=
s390/net/ctctty.c``
-ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/=
isdn/i4l/isdn_net_lib.h``
 SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
-CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/os=
s/cs46xx.c``
-SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.=
c``
 COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
-I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/os=
s/i810_audio.c``
-TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/os=
s/trident.c``
-ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanr=
outer.h`` pre 3.9]
 SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
 GDA_MAGIC             0x58464552       gda                      ``arch/mip=
s/include/asm/sn/gda.h``
-RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.=
c``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-PCXX_MAGIC            0x5c6df104       channel                  ``drivers/=
char/pcxx.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-I810_STATE_MAGIC      0x63657373       i810_state               ``sound/os=
s/i810_audio.c``
-TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/os=
s/trident.c``
-M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/os=
s/maestro3.c``
 FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
-SLOT_MAGIC            0x67267321       slot                     ``drivers/=
hotplug/cpqphp.h``
-SLOT_MAGIC            0x67267322       slot                     ``drivers/=
hotplug/acpiphp.h``
-LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
-OPROFILE_MAGIC        0x6f70726f       super_block              ``drivers/=
oprofile/oprofilefs.h``
-M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/os=
s/maestro3.c``
-VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/co=
re/memory.c``
-KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/co=
re/memory.c``
-PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/=
usb/media/pwc.h``
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
@@ -155,7 +112,6 @@ YAM_MAGIC             0xF10A7654       yam_port        =
         ``drivers/net/ha
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
-HTB_CMAGIC            0xFEFAFEF1       htb_class                ``net/sche=
d/sch_htb.c``
 NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Do=
cumentation/translations/zh_CN/process/magic-number.rst
index e4c225996af0..31669c1cfaa6 100644
--- a/Documentation/translations/zh_CN/process/magic-number.rst
+++ b/Documentation/translations/zh_CN/process/magic-number.rst
@@ -59,77 +59,34 @@ Linux =E9=AD=94=E6=9C=AF=E6=95=B0
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/=
linux/pg.h``
 CMAGIC                0x0111           user                     ``include/=
linux/a.out.h``
-MKISS_DRIVER_MAGIC    0x04bf           mkiss_channel            ``drivers/=
net/mkiss.h``
 HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/=
char/n_hdlc.c``
 APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86=
/kernel/apm_32.c``
 CYCLADES_MAGIC        0x4359           cyclades_port            ``include/=
linux/cyclades.h``
-DB_MAGIC              0x4442           fc_info                  ``drivers/=
net/iph5526_novram.c``
-DL_MAGIC              0x444d           fc_info                  ``drivers/=
net/iph5526_novram.c``
 FASYNC_MAGIC          0x4601           fasync_struct            ``include/=
linux/fs.h``
-FF_MAGIC              0x4646           fc_info                  ``drivers/=
net/iph5526_novram.c``
 ISICOM_MAGIC          0x4d54           isi_port                 ``include/=
linux/isicom.h``
-PTY_MAGIC             0x5001                                    ``drivers/=
char/pty.c``
-PPP_MAGIC             0x5002           ppp                      ``include/=
linux/if_pppvar.h``
-SSTATE_MAGIC          0x5302           serial_state             ``include/=
linux/serial.h``
 SLIP_MAGIC            0x5302           slip                     ``drivers/=
net/slip.h``
-STRIP_MAGIC           0x5303           strip                    ``drivers/=
net/strip.c``
 X25_ASY_MAGIC         0x5303           x25_asy                  ``drivers/=
net/x25_asy.h``
-SIXPACK_MAGIC         0x5304           sixpack                  ``drivers/=
net/hamradio/6pack.h``
-AX25_MAGIC            0x5316           ax_disp                  ``drivers/=
net/mkiss.h``
 TTY_MAGIC             0x5401           tty_struct               ``include/=
linux/tty.h``
 MGSL_MAGIC            0x5401           mgsl_info                ``drivers/=
char/synclink.c``
 TTY_DRIVER_MAGIC      0x5402           tty_driver               ``include/=
linux/tty_driver.h``
 MGSLPC_MAGIC          0x5402           mgslpc_info              ``drivers/=
char/pcmcia/synclink_cs.c``
 TTY_LDISC_MAGIC       0x5403           tty_ldisc                ``include/=
linux/tty_ldisc.h``
-USB_SERIAL_MAGIC      0x6702           usb_serial               ``drivers/=
usb/serial/usb-serial.h``
 FULL_DUPLEX_MAGIC     0x6969                                    ``drivers/=
net/ethernet/dec/tulip/de2104x.c``
-USB_BLUETOOTH_MAGIC   0x6d02           usb_bluetooth            ``drivers/=
usb/class/bluetty.c``
 RFCOMM_TTY_MAGIC      0x6d02                                    ``net/blue=
tooth/rfcomm/tty.c``
-USB_SERIAL_PORT_MAGIC 0x7301           usb_serial_port          ``drivers/=
usb/serial/usb-serial.h``
 CG_MAGIC              0x00090255       ufs_cylinder_group       ``include/=
linux/ufs_fs.h``
 RPORT_MAGIC           0x00525001       r_port                   ``drivers/=
char/rocket_int.h``
-LSEMAGIC              0x05091998       lse                      ``drivers/=
fc4/fc.c``
 GDTIOCTL_MAGIC        0x06030f07       gdth_iowr_str            ``drivers/=
scsi/gdth_ioctl.h``
 RIEBL_MAGIC           0x09051990                                ``drivers/=
net/atarilance.c``
 NBD_REQUEST_MAGIC     0x12560953       nbd_request              ``include/=
linux/nbd.h``
-RED_MAGIC2            0x170fc2a5       (any)                    ``mm/slab.=
c``
 BAYCOM_MAGIC          0x19730510       baycom_state             ``drivers/=
net/baycom_epp.c``
-ISDN_X25IFACE_MAGIC   0x1e75a2b9       isdn_x25iface_proto_data ``drivers/=
isdn/isdn_x25iface.h``
-ECP_MAGIC             0x21504345       cdkecpsig                ``include/=
linux/cdk.h``
-LSOMAGIC              0x27091997       lso                      ``drivers/=
fc4/fc.c``
-LSMAGIC               0x2a3b4d2a       ls                       ``drivers/=
fc4/fc.c``
-WANPIPE_MAGIC         0x414C4453       sdla_{dump,exec}         ``include/=
linux/wanpipe.h``
-CS_CARD_MAGIC         0x43525553       cs_card                  ``sound/os=
s/cs46xx.c``
-LABELCL_MAGIC         0x4857434c       labelcl_info_s           ``include/=
asm/ia64/sn/labelcl.h``
-ISDN_ASYNC_MAGIC      0x49344C01       modem_info               ``include/=
linux/isdn.h``
-CTC_ASYNC_MAGIC       0x49344C01       ctc_tty_info             ``drivers/=
s390/net/ctctty.c``
-ISDN_NET_MAGIC        0x49344C02       isdn_net_local_s         ``drivers/=
isdn/i4l/isdn_net_lib.h``
 SAVEKMSG_MAGIC2       0x4B4D5347       savekmsg                 ``arch/*/a=
miga/config.c``
-CS_STATE_MAGIC        0x4c4f4749       cs_state                 ``sound/os=
s/cs46xx.c``
-SLAB_C_MAGIC          0x4f17a36d       kmem_cache               ``mm/slab.=
c``
 COW_MAGIC             0x4f4f4f4d       cow_header_v1            ``arch/um/=
drivers/ubd_user.c``
-I810_CARD_MAGIC       0x5072696E       i810_card                ``sound/os=
s/i810_audio.c``
-TRIDENT_CARD_MAGIC    0x5072696E       trident_card             ``sound/os=
s/trident.c``
-ROUTER_MAGIC          0x524d4157       wan_device               [in ``wanr=
outer.h`` pre 3.9]
 SAVEKMSG_MAGIC1       0x53415645       savekmsg                 ``arch/*/a=
miga/config.c``
 GDA_MAGIC             0x58464552       gda                      ``arch/mip=
s/include/asm/sn/gda.h``
-RED_MAGIC1            0x5a2cf071       (any)                    ``mm/slab.=
c``
 EEPROM_MAGIC_VALUE    0x5ab478d2       lanai_dev                ``drivers/=
atm/lanai.c``
 HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``include/=
linux/hdlcdrv.h``
-PCXX_MAGIC            0x5c6df104       channel                  ``drivers/=
char/pcxx.h``
 KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/mip=
s/include/asm/sn/klkernvars.h``
-I810_STATE_MAGIC      0x63657373       i810_state               ``sound/os=
s/i810_audio.c``
-TRIDENT_STATE_MAGIC   0x63657373       trient_state             ``sound/os=
s/trident.c``
-M3_CARD_MAGIC         0x646e6f50       m3_card                  ``sound/os=
s/maestro3.c``
 FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/=
atm/fore200e.h``
-SLOT_MAGIC            0x67267321       slot                     ``drivers/=
hotplug/cpqphp.h``
-SLOT_MAGIC            0x67267322       slot                     ``drivers/=
hotplug/acpiphp.h``
-LO_MAGIC              0x68797548       nbd_device               ``include/=
linux/nbd.h``
-OPROFILE_MAGIC        0x6f70726f       super_block              ``drivers/=
oprofile/oprofilefs.h``
-M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/os=
s/maestro3.c``
-VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/co=
re/memory.c``
-KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/co=
re/memory.c``
-PWC_MAGIC             0x89DC10AB       pwc_device               ``drivers/=
usb/media/pwc.h``
 NBD_REPLY_MAGIC       0x96744668       nbd_reply                ``include/=
linux/nbd.h``
 ENI155_MAGIC          0xa54b872d       midway_eprom	        ``drivers/atm/=
eni.h``
 CODA_MAGIC            0xC0DAC0DA       coda_file_info           ``fs/coda/=
coda_fs_i.h``
@@ -138,7 +95,6 @@ YAM_MAGIC             0xF10A7654       yam_port         =
        ``drivers/net/ha
 CCB_MAGIC             0xf2691ad2       ccb                      ``drivers/=
scsi/ncr53c8xx.c``
 QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``drivers/=
scsi/arm/queue.c``
 QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``drivers/=
scsi/arm/queue.c``
-HTB_CMAGIC            0xFEFAFEF1       htb_class                ``net/sche=
d/sch_htb.c``
 NMI_MAGIC             0x48414d4d455201 nmi_s                    ``arch/mip=
s/include/asm/sn/nmi.h``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
--=20
2.24.0.432.g9d3f5f5b63-goog


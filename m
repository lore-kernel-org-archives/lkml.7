Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A989C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA5E21655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576154352;
	bh=AOYFYnm/QwSOy5p87g01avVPIVfE3pX9vMTBOBNYJMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=YQnSzas+xhHkG15Azx8pC5rsxj6BUuMdT7FzFxJvNd1Q67C09mbdAM8C8S7elKKo8
	 zKoXibO6C0RwMYzxA9p5ewZM2DIzjdS6ZIfH+4fq4FgP9B+3DAudh6It6F/c6xWDpd
	 55mFy6N8b7lM6F1+YtroLBn7X7ncWwwPoeKzBAm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfLLMjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:39:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40096 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbfLLMjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:39:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id s22so2101120ljs.7;
        Thu, 12 Dec 2019 04:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Sw0ukf7wzGfV0S4PyemmM+3GufpDJgjjMti8nOQtowA=;
        b=jfsknCKo1BnME88eEcwANd9b0vCsM//GVRmrGeGcWmqnxu3hZmcOEEea2hpSaZ9oVJ
         EMJRS7zCFlZ81GfGeTl9S1UxHglmILCTqGlkpwOGSUJZvsfg/GDt3ZkbvWbQJ6aB7SOp
         vdry5ua9MT5hX2c+UkE74UIqxRgg1rvDS/1UFO6EUr/URelWHuXQFVAB3ycu+ihpTEpK
         d9pv8xUT+yFTqFSMTerghZjb7LxqAMIffbXajU1/LhLsJX7W9i2whDmZy7V2TnQQ35g7
         z4q8BdRSjAcJLThEkDYwHz9RiVIaed+usq25N1bHADiFgx9bLJSyytLi+lVvh/YFKwcm
         h6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=Sw0ukf7wzGfV0S4PyemmM+3GufpDJgjjMti8nOQtowA=;
        b=ZFe1MRfBqyW+4Wa+kf3ATjcENyFxFu3bhG5YVSN6ySamof9dSlaSWa09B2sx6aWQ5q
         jyS4wPNGYlh7uQ9AYuCpqScwkGnb8mBMbciqLdLKfo34/JUJXHaCiCMUwA5sChBV7I0t
         cCowEomHyVAHbL90E6VCmzeeDtqZoENnUhHmj76UHC/1ogMHcvY9i5FrPS42Wxo89aHD
         uXr4CHKqE0gl6tjQ/bleB4tnZGRtZJgNX6BEhmALT6rmkYsUOiUh6CpWcB5XgJX4ff+a
         j/4hGc4Zj42vokkehcqIiLu0cA8pgA1U7Vk46/OP8vZWOOVMAGp+endOMK20w45ej8ux
         /Eng==
X-Gm-Message-State: APjAAAVMNQvno03ceTskT8ByLmBk1arKzJtmcT2mPek/FpwP7EbMhIR4
        rCdK0H7nTrlhQ4GDX7bS2sMNJmb545mrZw==
X-Google-Smtp-Source: APXvYqyhRn3nzO6Tl6IfxbYSL2MGOi1ajbCRxrhSacnHnpJf2bzSiNIxynTuY6O8nf7xlqfEehz2Jw==
X-Received: by 2002:a2e:721a:: with SMTP id n26mr5857888ljc.128.1576154347442;
        Thu, 12 Dec 2019 04:39:07 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id t27sm3012823ljd.26.2019.12.12.04.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 04:39:06 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     kernel@puri.sm, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Subject: Re: suspend problem with dwc3 gadget / g_multi when usb disconnected
In-Reply-To: <df4060e1-5ef6-3d2b-5dd4-5a0cb577bb68@puri.sm>
References: <38edc05e-680b-d881-49fc-e8230a93b2c8@puri.sm> <87blsgl88s.fsf@gmail.com> <df4060e1-5ef6-3d2b-5dd4-5a0cb577bb68@puri.sm>
Date:   Thu, 12 Dec 2019 14:39:51 +0200
Message-ID: <87fthpwwdk.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Martin Kepplinger <martin.kepplinger@puri.sm> writes:
>>> https://source.puri.sm/martin.kepplinger/linux-next/blob/next-20191205/=
librem5/arch/arm64/configs/librem5_defconfig
>>>
>>> So I want to have host and gadget mode (G_MULTI, most importantly a
>>> serial ACM console), and I'm having trouble with S3 suspend:
>>>
>>> * The most interesting case here: When I boot with USB disconnected
>>> (from the battery) I can't suspend or unload dwc3. After "echo mem >
>>> /sys/power/state" I get nothing in the my logs except
>>>
>>> [   18.107380] PM: suspend entry (deep)
>>>
>>> and the system hangs. similarly, I can't work around this by rmmod -f
>>> dwc3. What can go wrong here? I don't know enough about usb hci and why
>>> this shouldn't work. What can I do to help you here?
>>>
>>> * When I boot with USB connected, then unplug USB, I get:
>>>
>>> [   19.289602] dwc3 38100000.usb: request 000000006a19695c was not
>>> queued to ep3in
>>=20
>> please capture ftrace logs from dwc3. We have documentation for this:
>>=20
>> https://www.kernel.org/doc/html/latest/driver-api/usb/dwc3.html
>>=20
>> (note to self: update email address :-)
>
> thanks for getting back at me! I hope I won't confuse you by seemingly
> different issues:

no worries :-)

> First, the above message again: I see it (on -next-20191212) every time
> a few seconds after startup, also when keeping usb connected:
>
> [   38.375833] dwc3 38100000.usb: request 0000000051c55cfc was not
> queued to ep3in

Okay. This could be indicative of a race condition; we'll see

> and I append the "full" trace with that timestamp included. Just to
> paste a (maybe) relevant part here:
>
>
>      irq/41-dwc3-310   [000] d..2    38.375802: dwc3_writel: addr
> 0000000023f39630 value 00050c08
>      irq/41-dwc3-310   [000] d..2    38.375803: dwc3_readl: addr
> 0000000023f39630 value 00050808
>      irq/41-dwc3-310   [000] d..2    38.375804: dwc3_gadget_ep_cmd:
> ep2in: cmd 'End Transfer' [50c08] params 00000000 00000000 00000000 -->
> status: Successful
>      irq/41-dwc3-310   [000] d..2    38.375805: dwc3_readl: addr
> 000000002c8ca7cf value 40102400
>      irq/41-dwc3-310   [000] d..2    38.375806: dwc3_writel: addr
> 000000002c8ca7cf value 40102540
>      irq/41-dwc3-310   [000] d..2    38.375808: dwc3_readl: addr
> 00000000ad4ae082 value 00000003
>      irq/41-dwc3-310   [000] d..2    38.375809: dwc3_writel: addr
> 00000000ad4ae082 value 00000003
>      irq/41-dwc3-310   [000] d..2    38.375815: dwc3_ep_dequeue: ep3in:
> req 0000000051c55cfc length 0/0 zsI =3D=3D> 0
>      irq/41-dwc3-310   [000] d..2    38.383461: dwc3_free_request:
> ep3in: req 0000000051c55cfc length 0/0 zsI =3D=3D> 0
>      irq/41-dwc3-310   [000] d..2    38.383480: dwc3_gadget_ep_disable:
> ep2out: mps 512/1024 streams 15 burst 0 ring 16/11 flags E:swBp:>

     irq/41-dwc3-310   [000] d..1    38.375648: dwc3_event: event (00000101=
): Reset [U0]

I don't see why we're getting this reset here.

     irq/41-dwc3-310   [000] d..2    38.375664: dwc3_gadget_ep_disable: ep1=
in: mps 512/1024 streams 15 burst 0 ring 14/14 flags E:swBp:<

all endpoints are disabled and they're requests are freed. Nothing wrong th=
ere.

     irq/41-dwc3-310   [000] d..2    38.375681: dwc3_gadget_ep_cmd: ep1in: =
cmd 'End Transfer' [30c08] params 00000000 00000000 00000000 --> status: Su=
ccessful
     irq/41-dwc3-310   [000] d..1    38.375690: dwc3_free_request: ep1in: r=
eq 000000007144a82a length 114/114 ZsI =3D=3D> 0
     irq/41-dwc3-310   [000] d..1    38.375698: dwc3_free_request: ep1in: r=
eq 0000000084a5d489 length 134/134 ZsI =3D=3D> 0
     irq/41-dwc3-310   [000] d..1    38.375700: dwc3_free_request: ep1in: r=
eq 000000004fd6d4f7 length 0/0 zsI =3D=3D> 0
     irq/41-dwc3-310   [000] d..1    38.375702: dwc3_free_request: ep1in: r=
eq 0000000067b7b70a length 0/0 zsI =3D=3D> 0
     irq/41-dwc3-310   [000] d..1    38.375704: dwc3_free_request: ep1in: r=
eq 00000000e19d65f0 length 0/0 zsI =3D=3D> 0
     irq/41-dwc3-310   [000] d..1    38.375717: dwc3_free_request: ep1in: r=
eq 0000000005e9931c length 0/0 zsI =3D=3D> 0
     irq/41-dwc3-310   [000] d..1    38.375719: dwc3_free_request: ep1in: r=
eq 0000000036de964f length 0/0 zsI =3D=3D> 0
     irq/41-dwc3-310   [000] d..1    38.375721: dwc3_free_request: ep1in: r=
eq 0000000090a35af0 length 0/0 zsI =3D=3D> 0
     irq/41-dwc3-310   [000] d..1    38.375723: dwc3_free_request: ep1in: r=
eq 000000002289a9c8 length 0/0 zsI =3D=3D> 0
     irq/41-dwc3-310   [000] d..1    38.375724: dwc3_free_request: ep1in: r=
eq 00000000113f6f0d length 0/0 zsI =3D=3D> 0
     irq/41-dwc3-310   [000] d..2    38.375726: dwc3_gadget_ep_disable: ep1=
out: mps 512/1024 streams 15 burst 0 ring 20/11 flags E:swBp:>
     irq/41-dwc3-310   [000] d..2    38.375735: dwc3_gadget_ep_cmd: ep1out:=
 cmd 'End Transfer' [20c08] params 00000000 00000000 00000000 --> status: S=
uccessful
     irq/41-dwc3-310   [000] d..2    38.375743: dwc3_gadget_giveback: ep1ou=
t: req 00000000c4551c5c length 4294958658/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..2    38.375755: dwc3_gadget_giveback: ep1ou=
t: req 00000000fbe64702 length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..2    38.375758: dwc3_gadget_giveback: ep1ou=
t: req 000000000d2e5947 length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..2    38.375761: dwc3_gadget_giveback: ep1ou=
t: req 000000003ae2da7d length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..2    38.375763: dwc3_gadget_giveback: ep1ou=
t: req 0000000060248ce8 length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..2    38.375766: dwc3_gadget_giveback: ep1ou=
t: req 000000008d92c239 length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..2    38.375768: dwc3_gadget_giveback: ep1ou=
t: req 00000000b73f8103 length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..2    38.375771: dwc3_gadget_giveback: ep1ou=
t: req 00000000245d0fca length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..2    38.375774: dwc3_gadget_giveback: ep1ou=
t: req 00000000a62e97dd length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..2    38.375776: dwc3_gadget_giveback: ep1ou=
t: req 00000000af48ce89 length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..1    38.375781: dwc3_free_request: ep1out: =
req 00000000af48ce89 length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..1    38.375782: dwc3_free_request: ep1out: =
req 00000000a62e97dd length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..1    38.375784: dwc3_free_request: ep1out: =
req 00000000245d0fca length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..1    38.375785: dwc3_free_request: ep1out: =
req 00000000b73f8103 length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..1    38.375786: dwc3_free_request: ep1out: =
req 000000008d92c239 length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..1    38.375788: dwc3_free_request: ep1out: =
req 0000000060248ce8 length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..1    38.375789: dwc3_free_request: ep1out: =
req 000000003ae2da7d length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..1    38.375791: dwc3_free_request: ep1out: =
req 000000000d2e5947 length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..1    38.375792: dwc3_free_request: ep1out: =
req 00000000fbe64702 length 0/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..1    38.375794: dwc3_free_request: ep1out: =
req 00000000c4551c5c length 4294958658/1578 zsI =3D=3D> -108
     irq/41-dwc3-310   [000] d..2    38.375795: dwc3_gadget_ep_disable: ep2=
in: mps 8/1024 streams 15 burst 0 ring 5/5 flags E:swBp:<
     irq/41-dwc3-310   [000] d..2    38.375804: dwc3_gadget_ep_cmd: ep2in: =
cmd 'End Transfer' [50c08] params 00000000 00000000 00000000 --> status: Su=
ccessful
     irq/41-dwc3-310   [000] d..2    38.375815: dwc3_ep_dequeue: ep3in: req=
 0000000051c55cfc length 0/0 zsI =3D=3D> 0
     irq/41-dwc3-310   [000] d..2    38.383461: dwc3_free_request: ep3in: r=
eq 0000000051c55cfc length 0/0 zsI =3D=3D> 0
     irq/41-dwc3-310   [000] d..2    38.383480: dwc3_gadget_ep_disable: ep2=
out: mps 512/1024 streams 15 burst 0 ring 16/11 flags E:swBp:>
     irq/41-dwc3-310   [000] d..2    38.383494: dwc3_gadget_ep_cmd: ep2out:=
 cmd 'End Transfer' [40c08] params 00000000 00000000 00000000 --> status: S=
uccessful

> Now, I still have a lot configured in (G_MULTI and much more) and will
> compare that to less later. But I see a second issue:
>
> On next-20191212 now when shutting down or doing rmmod with USB
> disconnected, I get the following and can always reproduce it:
>
> [   64.393272] WARNING: CPU: 3 PID: 884 at
> drivers/usb/dwc3/gadget.c:2719
> dwc3_stop_active_transfer.constprop.38+0xe8/0x100 [dwc3]

I don't see this timestamp in the trace data. Didn't you capture it? In
any case, this happens when End Transfer command returns an error:

static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
	bool interrupt)
{
	struct dwc3 *dwc =3D dep->dwc;
	struct dwc3_gadget_ep_cmd_params params;
	u32 cmd;
	int ret;

	if (!(dep->flags & DWC3_EP_TRANSFER_STARTED))
		return;

	/*
	 * NOTICE: We are violating what the Databook says about the
	 * EndTransfer command. Ideally we would _always_ wait for the
	 * EndTransfer Command Completion IRQ, but that's causing too
	 * much trouble synchronizing between us and gadget driver.
	 *
	 * We have discussed this with the IP Provider and it was
	 * suggested to giveback all requests here, but give HW some
	 * extra time to synchronize with the interconnect. We're using
	 * an arbitrary 100us delay for that.
	 *
	 * Note also that a similar handling was tested by Synopsys
	 * (thanks a lot Paul) and nothing bad has come out of it.
	 * In short, what we're doing is:
	 *
	 * - Issue EndTransfer WITH CMDIOC bit set
	 * - Wait 100us
	 *
	 * As of IP version 3.10a of the DWC_usb3 IP, the controller
	 * supports a mode to work around the above limitation. The
	 * software can poll the CMDACT bit in the DEPCMD register
	 * after issuing a EndTransfer command. This mode is enabled
	 * by writing GUCTL2[14]. This polling is already done in the
	 * dwc3_send_gadget_ep_cmd() function so if the mode is
	 * enabled, the EndTransfer command will have completed upon
	 * returning from this function and we don't need to delay for
	 * 100us.
	 *
	 * This mode is NOT available on the DWC_usb31 IP.
	 */

	cmd =3D DWC3_DEPCMD_ENDTRANSFER;
	cmd |=3D force ? DWC3_DEPCMD_HIPRI_FORCERM : 0;
	cmd |=3D interrupt ? DWC3_DEPCMD_CMDIOC : 0;
	cmd |=3D DWC3_DEPCMD_PARAM(dep->resource_index);
	memset(&params, 0, sizeof(params));
	ret =3D dwc3_send_gadget_ep_cmd(dep, cmd, &params);
	WARN_ON_ONCE(ret);
	dep->resource_index =3D 0;

	if (dwc3_is_usb31(dwc) || dwc->revision < DWC3_REVISION_310A)
		udelay(100);
}

> [   64.405226] Modules linked in: rfkill st_magn_spi st_sensors_spi
> mousedev qmi_wwan caam_jr caamhash_desc caamalg_desc cdc_wdm option
> usbnet usb_wwan mii usbserial st_magn_i2c st_magn st_sensors_i2c
> st_sensors industrialio_triggered_buffer goodix kfifo_buf tcpci tcpm
> roles imx2_wdt watchdog aes_ce_blk crypto_simd typec bq25890_charger
> caam imx_sdma virt_dma error crct10dif_ce ghash_ce sha2_ce sha1_ce
> gpio_vibra usb_f_acm u_serial usb_f_rndis g_multi usb_f_mass_storage
> u_ether libcomposite ip_tables x_tables ipv6 nf_defrag_ipv6
> xhci_plat_hcd xhci_hcd usbcore dwc3 snvs_pwrkey ulpi udc_core
> phy_fsl_imx8mq_usb usb_common
> [   64.462126] CPU: 3 PID: 884 Comm: ip Not tainted
> 5.5.0-rc1-next-20191212-librem5-00019-g4fb81fdd9c7d #1
> [   64.471909] Hardware name: Purism Librem 5 devkit (DT)
> [   64.477264] pstate: 60000085 (nZCv daIf -PAN -UAO)
> [   64.482268] pc : dwc3_stop_active_transfer.constprop.38+0xe8/0x100 [dw=
c3]
> [   64.489351] lr : dwc3_stop_active_transfer.constprop.38+0x64/0x100 [dw=
c3]
> [   64.496421] sp : ffff00009f213240
> [   64.499874] x29: ffff00009f213240 x28: 0000000000000000
> [   64.505410] x27: ffff00009f2137b0 x26: ffff0000a4e0cc10
> [   64.510946] x25: 0000000000000001 x24: ffff0000a324518c
> [   64.516482] x23: ffff0000a3245193 x22: ffff0000a41f0080
> [   64.522018] x21: 0000000000000000 x20: ffff0000a4176600
> [   64.527553] x19: ffff800010ee87c8 x18: 0000000000000000
> [   64.533089] x17: 0000000000000000 x16: 0000000000000000
> [   64.538625] x15: 0000000000000000 x14: 0000000000000000
> [   64.544160] x13: ffff0000a4176868 x12: ffff0000a4176868
> [   64.549696] x11: ffffffffffff3f08 x10: 0000000000000008
> [   64.555232] x9 : ffffffffffff3f04 x8 : 0000000000000811
> [   64.560767] x7 : ffffffffffff3f00 x6 : ffffffffffff3f0c
> [   64.566303] x5 : 0000000000000000 x4 : ffff80001007483c
> [   64.571839] x3 : 0000000000000808 x2 : ffff00009f21327c
> [   64.577375] x1 : 0000000000000040 x0 : 00000000ffffff92
> [   64.582911] Call trace:
> [   64.585474]  dwc3_stop_active_transfer.constprop.38+0xe8/0x100 [dwc3]
> [   64.592194]  __dwc3_gadget_ep_disable+0x34/0x380 [dwc3]
> [   64.597649]  dwc3_gadget_ep_disable+0x44/0xf8 [dwc3]
> [   64.602841]  usb_ep_disable+0x34/0x100 [udc_core]
> [   64.607749]  eth_stop+0xb4/0x130 [u_ether]
> [   64.612026]  __dev_close_many+0xb4/0x138
> [   64.616116]  __dev_change_flags+0xb8/0x1d0
> [   64.620385]  dev_change_flags+0x28/0x68
> [   64.624384]  do_setlink+0x30c/0xc90
> [   64.628021]  __rtnl_newlink+0x3f8/0x788
> [   64.632018]  rtnl_newlink+0x54/0x80
> [   64.635654]  rtnetlink_rcv_msg+0x128/0x370
> [   64.639926]  netlink_rcv_skb+0x60/0x120
> [   64.643924]  rtnetlink_rcv+0x1c/0x28
> [   64.647650]  netlink_unicast+0x1b8/0x278
> [   64.651739]  netlink_sendmsg+0x1ac/0x3b0
> [   64.655829]  ____sys_sendmsg+0x250/0x298
> [   64.659918]  ___sys_sendmsg+0x88/0xc8
> [   64.663735]  __sys_sendmsg+0x70/0xc0
> [   64.667463]  __arm64_sys_sendmsg+0x28/0x30
> [   64.671736]  el0_svc_common.constprop.3+0x98/0x170
> [   64.676729]  el0_svc_handler+0x20/0x28
> [   64.680638]  el0_sync_handler+0x134/0x1a0
> [   64.684817]  el0_sync+0x140/0x180
> [   64.688271] ---[ end trace 4f6aa846a9c6f20c ]---
>
> ... again. at every shutdown or rmmod.
>
> I hope that this might be already helpful.

I need to see the trace events for this failure case too. You could add
ftrace_dump_on_oops to your cmdline and change the WARN_ONCE() to a
BUG_ON() or something.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl3yNRcACgkQzL64meEa
mQaZ7RAAnsh2sUJsfN1fyEUIJI7o48lSp2A4pEtCOAlVXrklLgWr+cFugKQRM1Ot
UfoxOHlIK0vE/6P9ELJ8I9HvdkwnhT/VETtYap8y/jTNDHpG1hXhCe5HLBs3cG9Y
5i0c1Arnt5Ta7kUkV3EnObXnBmLFZyQik2U4pN8HEFiXn/H2l9xlSKYw5BJ1nyWJ
BdFiICKscW0JeMavfqQliHQYP2ZYKPzjFnoaeh7kjd7UQbKgvyGiXeiXOdIfA3QO
Ms7XerNZnOHz0RreCGqtQo6XwS2faJ2SxmL+qDVVU5224PlvuZGAkGvIPZ/oKZkM
lOkXqJi1HyEuX5bVBpayy/+h1gkGNRZfwDPS5GhmafcaFlJbLBWAdcXYXNLorfKv
3eKPneanfPfA5fTDoqf7ITJ/DHD5/dX8BludVsag0GF37dexaaq2FxC87MiiunNH
c+KnplVBXUvexc6CL1G1U6LGydtFaXDdovxGx1u0F8Y5ksL1eafJGYQ1OxjOCc1s
R8DaBJW1ouameoMdyG8+TOki1XbuDdKgd0UzgshCOhKK8d8tt2RbTTBaUZe0RblJ
LfVmZYOQx8BTNHOoLQCCsV4yzwVUYKC4Q/wvLCJMBa/iGvNJ02viMHLg5RunnlBz
E9XmYRPL0Arpg1MVaPdSqGBX0VtYV8Zof4XheEoqZGLhtxNpFVM=
=eBhF
-----END PGP SIGNATURE-----
--=-=-=--

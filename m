Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5876FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207D821775
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Gj+2pJlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfK1Lrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:47:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:56153 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1Lrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 06:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574941667;
        bh=OFU9w/zGKnGvzzndAKFWY0LHoiUocdsTN9Uip9XNYq0=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=Gj+2pJlr18UWny0lLckaMwiWmx0Y1lo2FUigocmOHvzWOoEM8UY0gntyKYowyRC8A
         C1jJtTEYjBNrjeOayyCXewQbtjoxE6Pgg+UMufjijsZTpKFhaLPENfdIoomryW3Qeh
         gh/ZJw9LNh199hkH3FherJQf27JZyvK+gSD3qdk8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [185.75.75.47] ([185.75.75.47]) by web-mail.gmx.net
 (3c-app-gmx-bap74.server.lan [172.19.172.174]) (via HTTP); Thu, 28 Nov 2019
 12:47:46 +0100
MIME-Version: 1.0
Message-ID: <trinity-37493268-972d-4d03-b299-82bba385422e-1574941666927@3c-app-gmx-bap74>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     linux-kernel@vger.kernel.org
Subject: [BUG] NULL-Pointer crash in mutex_can_spin_on_owner
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 28 Nov 2019 12:47:46 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:W2Jgrg0rFtUa8WjF4GWauBeXj2myMTKCAVXLzQ4PRJ/W9lfCNqW4LLaT45ip9rZ7a13pQ
 386MDc2WxRZVq6iGAyY17pDj05KZL5T7uQh8OvrFZ2tfz0FhnT0mMow4dijvlPPy/PASwzTHwDBE
 UD2i0pq9EarmU/5/kW4bgOlQvUkBw2Wsu+/ohwLBu3hFpodZcO2d1aYctkO5MQ5uof6JFlKSA2ke
 1BfUGe1z99Oeg+ZeEA8QQBKWYhqHfUdVcRSnJ59NnuJlz30wSy+xzsteCHYA6ro8RaKZeZvWg3X/
 lA=
X-UI-Out-Filterresults: notjunk:1;V03:K0:p8shFzX6iA8=:lJl9RBj41xb70z730a+KSt
 cntxJQRtobkms+LAd1/0sM0zKW7JRZlpUd9XJZwweZPsIBNe8eFFFLCPHIoofSE3O54qtV7dk
 AGtvM2RQxiahYHcpdfIueEqQKTc5YJ5KRBPpyUICyhaZLgFVnEvsqUNoD0yQIGqYHfUcSAiL4
 X5BpbyOHbzPSvuru5KMjbgRfqvlSxoKip/RiJezTkqAGkhfnl70HieU/+djx8AI0kfsGicrxO
 xn8XhMMqF1t9CIOltgySPY4uWKECS6TxvSLen1Uu31ECk9MxfU2rwUGPCcO0w627hqemp6pqJ
 XBVVpILdVsUwMY3xOUlq3Fx63ruCbU9LPN0i8xRcgI1ZCA+U+OMxhhCIUGLoZiZBew2I1Pb3G
 4/vMz7FiyZJCFxefYyYglGnxBbdkmXCJ90J42ihvpqGpe5l287y/PQTtU0nnj313GeFfa+Gik
 p+dcjYqHZ474r1VoI5XYGGuY9E8TmdnC6T7kURlAGPMRWUfwpt7BDFp3/MhZcgOWF4P8TtNmj
 mzS2UT5J4/85RkOY9dusp8Mt5WwRqdcW+b2U4DkhvjjlrOK58w7xagh/V1whMLZ4IvAhfRJ21
 pVr8piWdAbv/vXio5eMLP6LPlX4V+LZd14lXBRugdryyJNm9PcdeSJNzE7KJ3+EqIgGLN1pNm
 7J7IBgQz8tHrFxTNEKLW418/4BFFasne7NqkYexE0YYM8xdEpyRPfZB79euvggg7ueuc=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i got a crash in mutex_can_spin_on_owner while trying to get mPCIe card (a=
th10 driver) running in bananapi r64 (aarch64) using kernel 5.4

[   11.381653] DEBUG: Passed mtk_pcie_irq_domain_alloc 441 port:0x00000000=
bc0b7874 lock:0x0000000023f7fc2a
[   11.391943] Unable to handle kernel NULL pointer dereference at virtual=
 address 0000000000000260
[   11.402178] Mem abort info:
[   11.406356]   ESR =3D 0x96000005
[   11.410868]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[   11.417530]   SET =3D 0, FnV =3D 0
[   11.421997]   EA =3D 0, S1PTW =3D 0
[   11.425220] Data abort info:
[   11.428196]   ISV =3D 0, ISS =3D 0x00000005
[   11.428199]   CM =3D 0, WnR =3D 0
[   11.428203] user pgtable: 4k pages, 39-bit VAs, pgdp=3D000000007c24b000
[   11.428206] [0000000000000260] pgd=3D0000000000000000, pud=3D0000000000=
000000
[   11.428214] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[   11.428218] Modules linked in: ath10k_pci(+) ath10k_core mt7622(+) mt76=
 ath mac80211 libarc4 cfg80211 btmtkuart
034-ga5669c8a8027-dirty #32
[   11.428243] Hardware name: Bananapi BPI-R64 (DT)
[   11.428248] pstate: 00000005 (nzcv daif -PAN -UAO)
[   11.428260] pc : mutex_can_spin_on_owner+0x30/0x5c
[   11.428264] lr : mutex_can_spin_on_owner+0x24/0x5c
[   11.428268] sp : ffffffc010c3b580
[   11.428271] x29: ffffffc010c3b580 x28: 0000000000080000
[   11.428275] x27: ffffffc010c3b838 x26: 0000000000000001
[   11.428280] x25: 000000000000008d x24: 0000000000000002
[   11.428284] x23: ffffff803d4e6800 x22: ffffff803e155500
[   11.428288] x21: 0000000000000001 x20: ffffffc010808000
[   11.428293] x19: ffffff803e155500 x18: 0000000000000000
[   11.428297] x17: 0000000000000000 x16: 0000000000000000
[   11.428302] x15: 0000000000000000 x14: 0000000000000000
[   11.428306] x13: 0000000000000000 x12: 0000000000000001
[   11.428310] x11: 0000000000000001 x10: 00000000000007c0
[   11.428315] x9 : ffffffc010c3b3c0 x8 : ffffff803fdb07d0
[   11.428319] x7 : ffffff803e155500 x6 : ffffff800336a400
[   11.428324] x5 : 0000000000000220 x4 : 0000000000000220
[   11.428328] x3 : ffffffc0108b7000 x2 : ffffff800336a400
[   11.428332] x1 : ffffff800336a400 x0 : 0000000000000220
[   11.428337] Call trace:
[   11.428342]  mutex_can_spin_on_owner+0x30/0x5c
[   11.428349]  __mutex_lock.isra.9+0x58/0x2a4
[   11.428356]  __mutex_lock_slowpath+0x10/0x18
[   11.428360]  mutex_lock+0x44/0x68
[   11.428366]  mtk_pcie_irq_domain_alloc+0x60/0x120
[   11.428371]  irq_domain_alloc_irqs_hierarchy+0x14/0x1c
[   11.428375]  irq_domain_alloc_irqs_parent+0x14/0x24
[   11.428379]  msi_domain_alloc+0x90/0x130
[   11.428382]  irq_domain_alloc_irqs_hierarchy+0x14/0x1c
[   11.428386]  __irq_domain_alloc_irqs+0x140/0x2b4
[   11.428390]  msi_domain_alloc_irqs+0x134/0x2c4
[   11.428394]  pci_msi_setup_msi_irqs+0x28/0x38
[   11.428398]  __pci_enable_msi_range+0x208/0x30c
[   11.428401]  pci_enable_msi+0x18/0x28
[   11.428418]  ath10k_pci_probe+0x50c/0x6d8 [ath10k_pci]
[   11.428423]  pci_device_probe+0xb4/0x144
[   11.428430]  really_probe+0x238/0x3f8
[   11.428436]  driver_probe_device+0x114/0x124
[   11.428440]  device_driver_attach+0x40/0x68
[   11.428444]  __driver_attach+0x134/0x138
[   11.428448]  bus_for_each_dev+0x78/0xbc

(gdb) list *(mtk_pcie_irq_domain_alloc+0x60)
0xffffffc0102e68d0 is in mtk_pcie_irq_domain_alloc (drivers/pci/controller=
/pcie-mediatek.c:446).
441             printk(KERN_ALERT "DEBUG: Passed %s %d port:0x%p lock:0x%p=
\n",__FUNCTION__,__LINE__,(void *)port,(void *)&port->lock);
442
443             WARN_ON(nr_irqs !=3D 1);
444             mutex_lock(&port->lock);
445
446             printk(KERN_ALERT "DEBUG: Passed %s %d\n",__FUNCTION__,__L=
INE__);
447             bit =3D find_first_zero_bit(port->msi_irq_in_use, MTK_MSI_=
IRQS_NUM);
448             printk(KERN_ALERT "DEBUG: Passed %s %d bit:%lu,max:%u\n",_=
_FUNCTION__,__LINE__,bit,MTK_MSI_IRQS_NUM);
449
450             if (bit >=3D MTK_MSI_IRQS_NUM) {

(gdb) list *(mutex_can_spin_on_owner+0x30)
0xffffffc0100d96f8 is in mutex_can_spin_on_owner (kernel/locking/mutex.c:6=
05).
600             /*
601              * As lock holder preemption issue, we both skip spinning =
if task is not
602              * on cpu or its cpu is preempted
603              */
604             if (owner)
605                     retval =3D owner->on_cpu && !vcpu_is_preempted(tas=
k_cpu(owner));
606             rcu_read_unlock();
607
608             /*
609              * If lock->owner is not set, the mutex has been released.=
 Return true

mutex is initialized in mtk_pcie_allocate_msi_domains which is called befo=
re twice, so i guess the mutex itself is correctly initialized.

can you give me some hint to debug it?

regards Frank

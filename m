Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514E2C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7F8206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AFqox4q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKNP42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:56:28 -0500
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:11079
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726516AbfKNP42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:56:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwMIrT7Fp3TSlZivn8GMIjNuZ2VLvyzcv1o1cUrYbIIYKkSseYC54yY0H/BBA+WwhKna4U7uqGvfD2SOMU9CwqrJUCtRVRK4AY9NAtR/ggPrguwEG90dSquhDAKoK5PIIa/i3iHWVu+QQkEeT8QHC3ATBjiL7AiKLThQ7hM12omMoBM/XMeQlHBTWqk0LBMGJK3GTXK4hUSKtTE6t/4+DnDfmdp/rQAMcwrYEo6xQAyxrlK/vQ6AcemqWkBnttS7dISKUV21TadGRepw/+/JVEalTeuXQw9p00oFPUPO59ZPwSQVnEXgzrWJYk85OmgxFIuSqx8h15D80pjXGXErew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muuHCDXIzpkPl+ulZUldkH8TTVvo9gwv4YCPykSWSjk=;
 b=nN3/UtI7e46Gbby0kxbDEDUw8+PnHALtpuuhr1wbN8f6nVAeDkDyqUZHNg5I+EF6IRwTtQv5sqHPHVn30Q9LOhfbvOsxKdmiBKKDEzEcNJDMVMesVPxDKvEWUunx7h/uawalg4DbJxhEZuGt0qVqzIyLjmpzAl4nb5TBfxKLUsdUHOQ7Fi6MEY8DI0mrTIlc8XKaeLTyXtMvar/HVHO+jXrAczvxaBnGnj/x5vdq/N+zLh7+7ZvnYNwwUfOKkzHXGyqVVJzu+mYO9EgoDfofb1Qyhm6JW115QjcgBAaIvlkniFNUaneSYxeONVKJeyCbOQFyR18sJgW21UUSqQAZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muuHCDXIzpkPl+ulZUldkH8TTVvo9gwv4YCPykSWSjk=;
 b=AFqox4q2i3H7QWx2riAVbj60oGtd6J7VTbNqgFB6BhCU5N0m7WjjZtJH6TJc6yhsWRCRVyfZ6seRRJ9V6QjMYR5ojWUIdbnrOU2wCOixcPVF11pFEn1pBVdviP/js9Dz2iAKX6r7ffURt9SDJ5qEKQmhgBRyx2fPv+8yAjmN6eY=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6797.eurprd04.prod.outlook.com (10.255.196.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Thu, 14 Nov 2019 15:56:25 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2451.024; Thu, 14 Nov 2019
 15:56:25 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] irq_work: Fix IRQ_WORK_BUZY bit clearing
Thread-Topic: [PATCH] irq_work: Fix IRQ_WORK_BUZY bit clearing
Thread-Index: AQHVmkV8qA8DCtig5kmm4p3nbL5peQ==
Date:   Thu, 14 Nov 2019 15:56:25 +0000
Message-ID: <VI1PR04MB70232EC7B98497C2CEC633DCEE710@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20191113171201.14032-1-frederic@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f31ca2e-e68b-436e-3449-08d7691b33f2
x-ms-traffictypediagnostic: VI1PR04MB6797:
x-microsoft-antispam-prvs: <VI1PR04MB679722545DF0A635396306ADEE710@VI1PR04MB6797.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(199004)(189003)(229853002)(102836004)(53546011)(6506007)(478600001)(110136005)(76176011)(91956017)(76116006)(7696005)(99286004)(25786009)(44832011)(316002)(66946007)(476003)(486006)(66446008)(86362001)(66476007)(66556008)(64756008)(446003)(14454004)(52536014)(5660300002)(186003)(54906003)(7736002)(305945005)(74316002)(81166006)(6246003)(81156014)(6116002)(3846002)(26005)(8676002)(8936002)(2906002)(4326008)(71190400001)(71200400001)(256004)(55016002)(9686003)(14444005)(6436002)(66066001)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6797;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LEcGuKk++WsytKqzvqX/W7pOG5P8C7Zv8sM7B0eG36JO1F5s240uhvEv9JU5TDiBJLg3nt4AUYRK/LL8kSSHr9LY/6NGxCoX/byxm2m9fGjXP3tBDfvmBmt9P7PzJE3sIATdIsO1+RTcNtEevswrmFHQp3o0M+m8EG7MBwU3un+hef4NiKo7JJ/Qxj3u1/o5u90W3fc1tw5ENFn/XC+yc2Mjc26YwO5i76UJtYmjedHvQ+TIANpSA3KEjQ4MCb+nvpyXEoNL660MlBpA06L9f9bzAXOYTccuLr5wWL+WIXue92D/LWgQhlTmix47nN/zYCouT0zBSETpeKKx4vhhRNRiIiQFK010t/LAiJz0yKkYImG9ITlWfpvcOBMyG0FOUZ1bjIfuIH1Dic331puj5RtImd4s/wcBEC6HitTQxahXMf/wd01YnwFbrKa96nBB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f31ca2e-e68b-436e-3449-08d7691b33f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 15:56:25.1733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PlEAwJOpKFW9iCDXFTqrjymZl3UlGLPrAzoROTYvHbnza4BjIiwD/JLjlaO+V3dr6F2/vqJhAq9yZ4X7kKBKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6797
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.2019 19:12, Frederic Weisbecker wrote:=0A=
> While attempting to clear the buzy bit at the end of a work execution,=0A=
> atomic_cmpxchg() expects the value of the flags with the pending bit=0A=
> cleared as the old value. However we are passing by mistake the value of=
=0A=
> the flags before we actually cleared the pending bit.=0A=
=0A=
Busy is spelled with an S=0A=
=0A=
> =0A=
> As a result, clearing the buzy bit fails and irq_work_sync() may stall:=
=0A=
> =0A=
> 	watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [blktrace:4948]=0A=
> 	CPU: 0 PID: 4948 Comm: blktrace Not tainted 5.4.0-rc7-00003-gfeb4a51323b=
ab #1=0A=
> 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/=
01/2014=0A=
> 	RIP: 0010:irq_work_sync+0x4/0x10=0A=
> 	Call Trace:=0A=
> 	  relay_close_buf+0x19/0x50=0A=
> 	  relay_close+0x64/0x100=0A=
> 	  blk_trace_free+0x1f/0x50=0A=
> 	  __blk_trace_remove+0x1e/0x30=0A=
> 	  blk_trace_ioctl+0x11b/0x140=0A=
> 	  blkdev_ioctl+0x6c1/0xa40=0A=
> 	  block_ioctl+0x39/0x40=0A=
> 	  do_vfs_ioctl+0xa5/0x700=0A=
> 	  ksys_ioctl+0x70/0x80=0A=
> 	  __x64_sys_ioctl+0x16/0x20=0A=
> 	  do_syscall_64+0x5b/0x1d0=0A=
> 	  entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
> =0A=
> So clear the appropriate bit before passing the old flags to cmpxchg().=
=0A=
> =0A=
> Reported-by: kernel test robot <rong.a.chen@intel.com>=0A=
> Reported-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
> Fixes: feb4a51323ba ("irq_work: Slightly simplify IRQ_WORK_PENDING cleari=
ng")=0A=
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>=0A=
> Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>=0A=
> Cc: Peter Zijlstra <peterz@infradead.org> everywhere.=0A=
> Cc: Thomas Gleixner <tglx@linutronix.de>=0A=
> Cc: Ingo Molnar <mingo@kernel.org>=0A=
=0A=
Tested-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
=0A=
Without this patch switching cpufreq governors hangs on arm64.=0A=
=0A=
> ---=0A=
>   kernel/irq_work.c | 1 +=0A=
>   1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c=0A=
> index 49c53f80a13a..828cc30774bc 100644=0A=
> --- a/kernel/irq_work.c=0A=
> +++ b/kernel/irq_work.c=0A=
> @@ -158,6 +158,7 @@ static void irq_work_run_list(struct llist_head *list=
)=0A=
>   		 * Clear the BUSY bit and return to the free state if=0A=
>   		 * no-one else claimed it meanwhile.=0A=
>   		 */=0A=
> +		flags &=3D ~IRQ_WORK_PENDING;=0A=
>   		(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);=0A=
>   	}=0A=
>   }=0A=
> =0A=
=0A=

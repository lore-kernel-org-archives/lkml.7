Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC9FC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FB822D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 08:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="L6V5I2Ar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfHUIiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 04:38:00 -0400
Received: from mail-eopbgr770135.outbound.protection.outlook.com ([40.107.77.135]:34478
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727719AbfHUIh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 04:37:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isBRGZwdacgOnVWN8NxnWU9EIqapAXaZUcZL1qDBFW00dMfg/m5cY9qWmWVqmrj5vPp6ePyNt5CifcwJV8NN7pKrfjMLKNdDUUaIjScLf2pWOkmJ32AqhtIZeeBsVaODz1XVbK60xQLWH72n7tbFDLpgZ3ht57Z8VyWOxIfDyzau/NmLl1HxJTg7I687ok1H0is3bqyhSEyCTMzKylkOVlsI2QtUK/rmBSIrjYqW17XA8efuMyfPs795J4crSHehio2qFiecZKOLmsFKPG5fR7HGzTN7x3AERmhlKMHkUD+0VU0k+JjBlIMRU2LXxaZGhgZnXVrqqoVTgcUdLs2e0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i962kHa0hv8hb8jiQn8JeH6PMtU7hLVBaVSqwP0izs=;
 b=F7x3pAPFpBF1F2W6Fyifej1fuArYtwA4qWamVr34vXF0+xxxNT1uuVnHG4SS/ybNxuzsj5QCZCa+hLtbCkO8T7L2wL2ElB/NsXkwNFtg/4YSSbAITK074ZiXIkej8DA+oySeJwnTziatDK7rLboP6HdAc62wxdFu1IPVt6OcsRRb0t4xHWFhJQJV15CmUHo0S5auCtqyMHYVK/6O9UmC9Z2GrGT9fQFvRNbdQVTwG11jA5ca+79oiCur/Mps2NfS9ptpWrLJECT/LLYlipuFaizLgMyQH2ZZSx4B/w4xkIbZVc1kpe65+RMhP6OfXqPZtpPQvwPYRoFntLdRQG9PYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i962kHa0hv8hb8jiQn8JeH6PMtU7hLVBaVSqwP0izs=;
 b=L6V5I2ArRcrqkgLpYugTqa0QvgfrdT2oBWr0nA7PPKDaMlAYFzJnYokr+ZxVfvnpaMc5uoMKaV6VjK8hPtwv3QzOonv32sWMwrWFp5dolD+ixmnGlCzNysrkwZQHbOEKm5UpikIDFvfDKufOtuIv89S7WXODzUwAjwxhjiEn9+o=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.11; Wed, 21 Aug 2019 08:37:55 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d%11]) with mapi id 15.20.2220.000; Wed, 21 Aug
 2019 08:37:55 +0000
From:   Long Li <longli@microsoft.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] nvme: complete request in work queue on CPU with
 flooded interrupts
Thread-Topic: [PATCH 3/3] nvme: complete request in work queue on CPU with
 flooded interrupts
Thread-Index: AQHVVx6V8EslWtuw80WR9kecrOlyh6cDy8QAgAF5Y5A=
Date:   Wed, 21 Aug 2019 08:37:55 +0000
Message-ID: <CY4PR21MB0741A817BEB880C8DC526ECFCEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <1566281669-48212-4-git-send-email-longli@linuxonhyperv.com>
 <20190820095240.GH2332@hirez.programming.kicks-ass.net>
In-Reply-To: <20190820095240.GH2332@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:ede6:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55f9a461-022f-4b83-268f-08d72612dd30
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB01492043379A118FE8CE994FCEAA0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(71200400001)(71190400001)(22452003)(46003)(55016002)(66476007)(14444005)(256004)(7696005)(2501003)(6116002)(186003)(476003)(9686003)(486006)(66556008)(2906002)(64756008)(66446008)(76116006)(66946007)(4326008)(11346002)(446003)(6436002)(74316002)(76176011)(10090500001)(8936002)(5660300002)(305945005)(7736002)(110136005)(54906003)(8990500004)(6506007)(316002)(102836004)(229853002)(478600001)(81156014)(81166006)(86362001)(8676002)(25786009)(99286004)(14454004)(6246003)(53936002)(52536014)(33656002)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0741.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UZwNkEMLXOX9ZKKDG1TRO0eosn5VGU0+H7hqQehmI8Nbqdz1dJXcpaTZYZ68L+vdj5Yc7dhLV4iR9M5cLr+/8BXwWnnMiQS2ds8LEOhA/wAY+jrbV0Mr/ug0AT56V0vKaSxrk00mR5UzdDmu+R5UT8ZHMpc5txZCv5+D8xvDntIqexIqBMtWSbZdhtdQ/CcZvQPyupq84XjtijABOZX3xtQhi6doO4UIdhsphebdge2zcIDtvdkFFiqUjKtaApBcIHangz5N8U16WtitkG5WQiQ9nzCojZJoLfowabxmGEWDv2i730FC3EUKv9d+q3eBvib66sjT6v8heyAeKEaYbCkHLEgUDg3KVGCLXONUVWsvIkdygGraezC8N2fSpq0z4daCd9V1NEf2JDpPsL1wyYSZp6MDLR9GmrwQLlQDR08=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f9a461-022f-4b83-268f-08d72612dd30
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 08:37:55.6652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wqQwBAKU6IB6HTdASFe3ocHMPtfYsh+9iFSjvcsXrCtTa9RDkZ01Jf7jDHgTd2gK/BfiFZitU683K97ME7YPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>Subject: Re: [PATCH 3/3] nvme: complete request in work queue on CPU
>>>with flooded interrupts
>>>
>>>On Mon, Aug 19, 2019 at 11:14:29PM -0700, longli@linuxonhyperv.com
>>>wrote:
>>>> From: Long Li <longli@microsoft.com>
>>>>
>>>> When a NVMe hardware queue is mapped to several CPU queues, it is
>>>> possible that the CPU this hardware queue is bound to is flooded by
>>>> returning I/O for other CPUs.
>>>>
>>>> For example, consider the following scenario:
>>>> 1. CPU 0, 1, 2 and 3 share the same hardware queue 2. the hardware
>>>> queue interrupts CPU 0 for I/O response 3. processes from CPU 1, 2 and
>>>> 3 keep sending I/Os
>>>>
>>>> CPU 0 may be flooded with interrupts from NVMe device that are I/O
>>>> responses for CPU 1, 2 and 3. Under heavy I/O load, it is possible
>>>> that CPU 0 spends all the time serving NVMe and other system
>>>> interrupts, but doesn't have a chance to run in process context.
>>>
>>>Ideally -- and there is some code to affect this, the load-balancer will=
 move
>>>tasks away from this CPU.
>>>
>>>> To fix this, CPU 0 can schedule a work to complete the I/O request
>>>> when it detects the scheduler is not making progress. This serves mult=
iple
>>>purposes:
>>>
>>>Suppose the task waiting for the IO completion is a RT task, and you've =
just
>>>queued it to a regular work. This is an instant priority inversion.

This is a choice. We can either not "lock up" the CPU, or finish the I/O on=
 time from IRQ handler. I think throttling only happens in extreme conditio=
ns, which is rare. The purpose is to make the whole system responsive and h=
appy.

>>>
>>>> 1. This CPU has to be scheduled to complete the request. The other
>>>> CPUs can't issue more I/Os until some previous I/Os are completed.
>>>> This helps this CPU get out of NVMe interrupts.
>>>>
>>>> 2. This acts a throttling mechanisum for NVMe devices, in that it can
>>>> not starve a CPU while servicing I/Os from other CPUs.
>>>>
>>>> 3. This CPU can make progress on RCU and other work items on its queue=
.
>>>>
>>>> Signed-off-by: Long Li <longli@microsoft.com>
>>>> ---
>>>>  drivers/nvme/host/core.c | 57
>>>> +++++++++++++++++++++++++++++++++++++++-
>>>>  drivers/nvme/host/nvme.h |  1 +
>>>>  2 files changed, 57 insertions(+), 1 deletion(-)
>>>
>>>WTH does this live in the NVME driver? Surely something like this should=
 be
>>>in the block layer. I'm thinking there's fiber channel connected storage=
 that
>>>should be able to trigger much the same issues.

Yes this can be done in block layer. I'm not sure the best way to accomplis=
h this so implemented a NVMe patch to help test. The test results are promi=
sing in that we are getting 99.5% of performance while avoided CPU lockup. =
The challenge is to find a way to throttle a fast storage device.

>>>
>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c index
>>>> 6a9dd68c0f4f..576bb6fce293 100644
>>>> --- a/drivers/nvme/host/core.c
>>>> +++ b/drivers/nvme/host/core.c
>>>
>>>> @@ -260,9 +270,54 @@ static void nvme_retry_req(struct request *req)
>>>>  	blk_mq_delay_kick_requeue_list(req->q, delay);  }
>>>>
>>>> +static void nvme_complete_rq_work(struct work_struct *work) {
>>>> +	struct nvme_request *nvme_rq =3D
>>>> +		container_of(work, struct nvme_request, work);
>>>> +	struct request *req =3D blk_mq_rq_from_pdu(nvme_rq);
>>>> +
>>>> +	nvme_complete_rq(req);
>>>> +}
>>>> +
>>>> +
>>>>  void nvme_complete_rq(struct request *req)  {
>>>> -	blk_status_t status =3D nvme_error_status(req);
>>>> +	blk_status_t status;
>>>> +	int cpu;
>>>> +	u64 switches;
>>>> +	struct nvme_request *nvme_rq;
>>>> +
>>>> +	if (!in_interrupt())
>>>> +		goto skip_check;
>>>> +
>>>> +	nvme_rq =3D nvme_req(req);
>>>> +	cpu =3D smp_processor_id();
>>>> +	if (idle_cpu(cpu))
>>>> +		goto skip_check;
>>>> +
>>>> +	/* Check if this CPU is flooded with interrupts */
>>>> +	switches =3D get_cpu_rq_switches(cpu);
>>>> +	if (this_cpu_read(last_switch) =3D=3D switches) {
>>>> +		/*
>>>> +		 * If this CPU hasn't made a context switch in
>>>> +		 * MAX_SCHED_TIMEOUT ns (and it's not idle), schedule a
>>>work to
>>>> +		 * complete this I/O. This forces this CPU run non-interrupt
>>>> +		 * code and throttle the other CPU issuing the I/O
>>>> +		 */
>>>
>>>What if there was only a single task on that CPU? Then we'd never
>>>need/want to context switch in the first place.
>>>
>>>AFAICT all this is just a whole bunch of gruesome hacks piled on top one
>>>another.
>>>
>>>> +		if (sched_clock() - this_cpu_read(last_clock)
>>>> +				> MAX_SCHED_TIMEOUT) {
>>>> +			INIT_WORK(&nvme_rq->work,
>>>nvme_complete_rq_work);
>>>> +			schedule_work_on(cpu, &nvme_rq->work);
>>>> +			return;
>>>> +		}
>>>> +
>>>> +	} else {
>>>> +		this_cpu_write(last_switch, switches);
>>>> +		this_cpu_write(last_clock, sched_clock());
>>>> +	}
>>>> +
>>>> +skip_check:
>>>
>>>Aside from everything else; this is just sodding poor coding style. What=
 is
>>>wrong with something like:
>>>
>>>	if (nvme_complete_throttle(...))
>>>		return;
>>>
>>>> +	status =3D nvme_error_status(req);
>>>>
>>>>  	trace_nvme_complete_rq(req);
>>>>

Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7BDC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 00:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8BE207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 00:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TtZ90Hq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503655AbfIXAmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 20:42:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54412 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbfIXAmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 20:42:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8O0doER027969;
        Tue, 24 Sep 2019 00:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Hk8n8W6DgLJSYWpQiRIbNGzJE5GSzl/fQvUEMe7yZuE=;
 b=TtZ90Hq5VtqejR6pu+qZOlf9WoBXfwQpz7fReLerIhHC/eVuKjiCGG/918BrWMLPl64G
 l5fepJ8Kam2FcexKk6w2pF3gQsiIfmzbshr/wVrxZge+NcLW7npXCXP9JMsizZlbu/RZ
 R6GvsV3kQd8JzLMvDiJGM9U8Dv5Nbx7gohdHU/jgJSvBn0sbSXG1Qfcx8H//DmR6JDDT
 C0adF7V+9+ZFbzJq1qlFWV9C19V3zYcAVJEPoJ2ymeWr2aMjguhi0CA5Nt1gvY57QeaF
 A2bMwROWMIIZOSuWLSWMWXmXaql+WpoxnH/ixJTVcscjo3pbOYoFmLsxGZ/dqjBB1Lu2 QA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2v5b9tjb8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 00:41:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8O0bU1b140203;
        Tue, 24 Sep 2019 00:41:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2v6yvm7xn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 00:41:22 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8O0fIPd015801;
        Tue, 24 Sep 2019 00:41:18 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Sep 2019 17:41:17 -0700
Subject: Re: pstore does not work under xen
To:     Kees Cook <keescook@chromium.org>,
        James Dingwall <james@dingwall.me.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Juergen Gross <jgross@suse.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190919102643.GA9400@dingwall.me.uk>
 <3908561D78D1C84285E8C5FCA982C28F7F472015@ORSMSX115.amr.corp.intel.com>
 <20190919161430.GA28042@dingwall.me.uk>
 <ae56e2c0-b2d3-835d-04cb-e4404d979859@oracle.com>
 <20190923154227.GA11201@dingwall.me.uk> <201909231556.7FF7A11@keescook>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <be41da82-3adc-4ab1-e4f9-5fdf11ac4b08@oracle.com>
Date:   Mon, 23 Sep 2019 20:41:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201909231556.7FF7A11@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909240003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909240003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/19 6:59 PM, Kees Cook wrote:
> On Mon, Sep 23, 2019 at 03:42:27PM +0000, James Dingwall wrote:
>> On Thu, Sep 19, 2019 at 12:37:40PM -0400, Boris Ostrovsky wrote:
>>> On 9/19/19 12:14 PM, James Dingwall wrote:
>>>> On Thu, Sep 19, 2019 at 03:51:33PM +0000, Luck, Tony wrote:
>>>>>> I have been investigating a regression in our environment where pstore 
>>>>>> (efi-pstore specifically but I suspect this would affect all 
>>>>>> implementations) no longer works after upgrading from a 4.4 to 5.0 
>>>>>> kernel when running under xen.  (This is an Ubuntu kernel but I don't 
>>>>>> think there are patches which affect this area.)
>>>>> I don't have any answer for this ... but want to throw out the idea that
>>>>> VMM systems could provide some hypercalls to guests to save/return
>>>>> some blob of memory (perhaps the "save" triggers automagically if the
>>>>> guest crashes?).
>>>>>
>>>>> That would provide a much better pstore back end than relying on emulation
>>>>> of EFI persistent variables (which have severe contraints on size, and don't
>>>>> support some pstore modes because you can't dynamically update EFI variables
>>>>> hundreds of times per second).
>>>>>
>>>> For clarification this is a dom0 crash rather than an HVM guest with EFI.  I
>>>> should probably have also mentioned the xen verion has changed from 4.8.4 to
>>>> 4.11.2 in case its behaviour on detection of crashed domain has changed.
>>>>
>>>> (For capturing guest crashes we have enabled xenconsole logging so the
>>>> hvc0 log is available in dom0.)
>>>
>>> Do you only see this difference between 4.4 and 5.0 when you crash via
>>> sysrq?
>>>
>>> Because that's where things changed. On 4.4 we seem to be forcing an
>>> oops, which eventually calls kmsg_dump() and then panic. On 5.0 we call
>>> panic() directly from sysrq handler. And because Xen's panic notifier
>>> doesn't return we never get a chance to call kmsg_dump().
>>>
>> Ok, I see that change in 8341f2f222d729688014ce8306727fdb9798d37e.  I 
>> hadn't tested it any other way before.  Using the null pointer 
>> de-reference module code at [1] a pstore record is generated as expected 
>> when the module is loaded (panic_on_oops=1).
> This change looks correct -- it just gets us directly to the panic()
> state instead of exercising the various exception handlers.
>
>> I have also tested swapping the kmsg_dump() / 
>> atomic_notifier_call_chain() around in panic.c and this also results in 
>> a pstore record being created with sysrq-c.  I don't know if that would 
>> be an acceptable solution though since it may break behaviour that other 
>> things depend on.
> I don't think reordering these is a good idea: as the comments say,
> there might be work done in the notifier chain that kmsg_dump() will
> want to capture (e.g. the KASLR base offset).
>
> The situation seems to be that notifier callbacks must return -- I think
> Xen needs fixing here.
>

I only had one quick sanity test with a PV guest so this needs more
testing. James, can you give it a try?


diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 750f46ad018a..d88f118028b4 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -269,16 +269,17 @@ void xen_reboot(int reason)
                BUG();
 }
 
+static int reboot_reason = SHUTDOWN_reboot;
 void xen_emergency_restart(void)
 {
-       xen_reboot(SHUTDOWN_reboot);
+       xen_reboot(reboot_reason);
 }
 
 static int
 xen_panic_event(struct notifier_block *this, unsigned long event, void
*ptr)
 {
        if (!kexec_crash_loaded())
-               xen_reboot(SHUTDOWN_crash);
+               reboot_reason = SHUTDOWN_crash;
        return NOTIFY_DONE;
 }
 
@@ -290,6 +291,8 @@ static struct notifier_block xen_panic_block = {
 int xen_panic_handler_init(void)
 {
        atomic_notifier_chain_register(&panic_notifier_list,
&xen_panic_block);
+       if (panic_timeout == 0)
+               set_arch_panic_timeout(-1, CONFIG_PANIC_TIMEOUT);
        return 0;
 }



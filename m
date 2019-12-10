Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEA3C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B5020836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576002764;
	bh=DIUG46LQ5WUxMD9mvcst9fXDYZ7v6nXelshji9u8+yM=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=wFrsCMmlXrUvLms81gZhMl5rzFdYBbyIiCP0zydkE7n1HqojS1iG6lr8BXBloFzWw
	 sH71KReTkGgUh7e6TOads3rPvpXb9rUS0oFJHpKVuWMQfIeY/wjKiXNDIkiwQN8H8v
	 WcJt++qLN7pU2gWj5f9tyRSkX77ZEGcXGcMj8KRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfLJScn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:32:43 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:60857 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727329AbfLJScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:32:42 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iekJH-0004nd-IO; Tue, 10 Dec 2019 19:32:35 +0100
To:     John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity  for managed interrupt
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Dec 2019 18:32:35 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, <tglx@linutronix.de>,
        <chenxiang66@hisilicon.com>, <bigeasy@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <hare@suse.com>, <hch@lst.de>,
        <axboe@kernel.dk>, <bvanassche@acm.org>, <peterz@infradead.org>,
        <mingo@redhat.com>
In-Reply-To: <06d1e2ff-9ec7-2262-25a0-4503cb204b0b@huawei.com>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
 <20191210014335.GA25022@ming.t460p>
 <28424a58-1159-c3f9-1efb-f1366993afcf@huawei.com>
 <048746c22898849d28985c0f65cf2c2a@www.loen.fr>
 <ce1b93c6-8ff9-6106-84af-909ec52d49e5@huawei.com>
 <6e513d25d8b0c6b95d37a64df0c27b78@www.loen.fr>
 <06d1e2ff-9ec7-2262-25a0-4503cb204b0b@huawei.com>
Message-ID: <5caa8414415ab35e74662ac0a30bb4ac@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: john.garry@huawei.com, ming.lei@redhat.com, tglx@linutronix.de, chenxiang66@hisilicon.com, bigeasy@linutronix.de, linux-kernel@vger.kernel.org, hare@suse.com, hch@lst.de, axboe@kernel.dk, bvanassche@acm.org, peterz@infradead.org, mingo@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-10 12:05, John Garry wrote:
> On 10/12/2019 11:36, Marc Zyngier wrote:
>> On 2019-12-10 10:59, John Garry wrote:
>>>>>
>>>>> There is no lockup, just a potential performance boost in this 
>>>>> change.
>>>>>
>>>>> My colleague Xiang Chen can provide specifics of the test, as he 
>>>>> is
>>>>> the one running it.
>>>>>
>>>>> But one key bit of info - which I did not think most relevant 
>>>>> before
>>>>> - that is we have 2x SAS controllers running the throughput test 
>>>>> on
>>>>> the same host.
>>>>>
>>>>> As such, the completion queue interrupts would be spread 
>>>>> identically
>>>>> over the CPUs for each controller. I notice that ARM GICv3 ITS
>>>>> interrupt controller (which we use) does not use the generic irq
>>>>> matrix allocator, which I think would really help with this.
>>>>>
>>>>> Hi Marc,
>>>>>
>>>>> Is there any reason for which we couldn't utilise of the generic 
>>>>> irq
>>>>> matrix allocator for GICv3?
>>>>
>>>
>>> Hi Marc,
>>>
>>>> For a start, the ITS code predates the matrix allocator by about 
>>>> three
>>>> years. Also, my understanding of this allocator is that it allows
>>>> x86 to cope with a very small number of possible interrupt vectors
>>>> per CPU. The ITS doesn't have such issue, as:
>>>> 1) the namespace is global, and not per CPU
>>>> 2) the namespace is *huge*
>>>> Now, what property of the matrix allocator is the ITS code 
>>>> missing?
>>>> I'd be more than happy to improve it.
>>>
>>> I think specifically the property that the matrix allocator will 
>>> try
>>> to find a CPU for irq affinity which "has the lowest number of 
>>> managed
>>> IRQs allocated" - I'm quoting the comment on 
>>> matrix_find_best_cpu_managed().
>> But that decision is due to allocation constraints. You can have at 
>> most
>> 256 interrupts per CPU, so the allocator tries to balance it.
>> On the contrary, the ITS does care about how many interrupt target 
>> any
>> given CPU. The whole 2^24 interrupt namespace can be thrown at a 
>> single
>> CPU.
>>
>>> The ITS code will make the lowest online CPU in the affinity mask 
>>> the
>>> target CPU for the interrupt, which may result in some CPUs 
>>> handling
>>> so many interrupts.
>> If what you want is for the *default* affinity to be spread around,
>> that should be achieved pretty easily. Let me have a think about how
>> to do that.
>
> Cool, I anticipate that it should help my case.
>
> I can also seek out some NVMe cards to see how it would help a more
> "generic" scenario.

Can you give the following a go? It probably has all kind of warts on
top of the quality debug information, but I managed to get my D05 and
a couple of guests to boot with it. It will probably eat your data,
so use caution! ;-)

Thanks,

         M.

diff --git a/drivers/irqchip/irq-gic-v3-its.c 
b/drivers/irqchip/irq-gic-v3-its.c
index e05673bcd52b..301ee3bc0602 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -177,6 +177,8 @@ static DEFINE_IDA(its_vpeid_ida);
  #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
  #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + 
SZ_128K)

+static DEFINE_PER_CPU(atomic_t, cpu_lpi_count);
+
  static u16 get_its_list(struct its_vm *vm)
  {
  	struct its_node *its;
@@ -1287,42 +1289,76 @@ static void its_unmask_irq(struct irq_data *d)
  	lpi_update_config(d, 0, LPI_PROP_ENABLED);
  }

+static int its_pick_target_cpu(struct its_device *its_dev, const 
struct cpumask *cpu_mask)
+{
+	unsigned int cpu = nr_cpu_ids, tmp;
+	int count = S32_MAX;
+
+	for_each_cpu_and(tmp, cpu_mask, cpu_online_mask) {
+		int this_count = per_cpu(cpu_lpi_count, tmp).counter;
+		if (this_count < count) {
+			cpu = tmp;
+		        count = this_count;
+		}
+	}
+
+	return cpu;
+}
+
  static int its_set_affinity(struct irq_data *d, const struct cpumask 
*mask_val,
  			    bool force)
  {
-	unsigned int cpu;
-	const struct cpumask *cpu_mask = cpu_online_mask;
  	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
-	struct its_collection *target_col;
+	int ret = IRQ_SET_MASK_OK_DONE;
  	u32 id = its_get_event_id(d);
+	cpumask_var_t tmpmask;

  	/* A forwarded interrupt should use irq_set_vcpu_affinity */
  	if (irqd_is_forwarded_to_vcpu(d))
  		return -EINVAL;

-       /* lpi cannot be routed to a redistributor that is on a foreign 
node */
-	if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
-		if (its_dev->its->numa_node >= 0) {
-			cpu_mask = cpumask_of_node(its_dev->its->numa_node);
-			if (!cpumask_intersects(mask_val, cpu_mask))
-				return -EINVAL;
+	if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_and(tmpmask, mask_val, cpu_online_mask);
+
+	if (its_dev->its->numa_node >= 0)
+		cpumask_and(tmpmask, tmpmask, 
cpumask_of_node(its_dev->its->numa_node));
+
+	if (cpumask_empty(tmpmask)) {
+		/* LPI cannot be routed to a redistributor that is on a foreign node 
*/
+		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
+			ret = -EINVAL;
+			goto out;
  		}
+
+		cpumask_copy(tmpmask, cpu_online_mask);
  	}

-	cpu = cpumask_any_and(mask_val, cpu_mask);
+	if (!cpumask_test_cpu(its_dev->event_map.col_map[id], tmpmask)) {
+		struct its_collection *target_col;
+		int cpu;

-	if (cpu >= nr_cpu_ids)
-		return -EINVAL;
+		cpu = its_pick_target_cpu(its_dev, tmpmask);
+		if (cpu >= nr_cpu_ids) {
+			ret = -EINVAL;
+			goto out;
+		}

-	/* don't set the affinity when the target cpu is same as current one 
*/
-	if (cpu != its_dev->event_map.col_map[id]) {
+		pr_info("IRQ%d CPU%d -> CPU%d\n",
+			d->irq, its_dev->event_map.col_map[id], cpu);
+		atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
+		atomic_dec(per_cpu_ptr(&cpu_lpi_count,
+				       its_dev->event_map.col_map[id]));
  		target_col = &its_dev->its->collections[cpu];
  		its_send_movi(its_dev, target_col, id);
  		its_dev->event_map.col_map[id] = cpu;
  		irq_data_update_effective_affinity(d, cpumask_of(cpu));
  	}

-	return IRQ_SET_MASK_OK_DONE;
+out:
+	free_cpumask_var(tmpmask);
+	return ret;
  }

  static u64 its_irq_get_msi_base(struct its_device *its_dev)
@@ -2773,22 +2809,28 @@ static int its_irq_domain_activate(struct 
irq_domain *domain,
  {
  	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
  	u32 event = its_get_event_id(d);
-	const struct cpumask *cpu_mask = cpu_online_mask;
-	int cpu;
+	int cpu = nr_cpu_ids;

-	/* get the cpu_mask of local node */
-	if (its_dev->its->numa_node >= 0)
-		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
+	/* Find the least loaded CPU on the local node */
+	if (its_dev->its->numa_node >= 0) {
+		cpu = its_pick_target_cpu(its_dev,
+					  cpumask_of_node(its_dev->its->numa_node));
+		if (cpu < 0)
+			return cpu;

-	/* Bind the LPI to the first possible CPU */
-	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
-	if (cpu >= nr_cpu_ids) {
-		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
+		if (cpu >= nr_cpu_ids &&
+		    (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144))
  			return -EINVAL;
+	}

-		cpu = cpumask_first(cpu_online_mask);
+	if (cpu >= nr_cpu_ids) {
+		cpu = its_pick_target_cpu(its_dev, cpu_online_mask);
+		if (cpu < 0)
+			return cpu;
  	}

+	pr_info("picked CPU%d IRQ%d\n", cpu, d->irq);
+	atomic_inc(per_cpu_ptr(&cpu_lpi_count, cpu));
  	its_dev->event_map.col_map[event] = cpu;
  	irq_data_update_effective_affinity(d, cpumask_of(cpu));

@@ -2803,6 +2845,8 @@ static void its_irq_domain_deactivate(struct 
irq_domain *domain,
  	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
  	u32 event = its_get_event_id(d);

+	atomic_dec(per_cpu_ptr(&cpu_lpi_count,
+			       its_dev->event_map.col_map[event]));
  	/* Stop the delivery of interrupts */
  	its_send_discard(its_dev, event);
  }

-- 
Jazz is not dead. It just smells funny...

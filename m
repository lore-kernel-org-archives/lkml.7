Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAF1C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCD2214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555625437;
	bh=+8kxRplTOe7E7T/ZfT5Mbud+/kinZxr5/Y5RgbKLlb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LKpSk0unSN0Ni0ZjEe6c7UC/Y0rABIGe7OXYQv/sEtw5OkYAZwGHCuJ8FHCrvRQ/p
	 kV7URlGaEqsRPpcG1TTgy+PUjNjVKxlxP+k4eBiQHOieok8aeGNLHrcEUVaGrR86bV
	 p2CP0jWkQklbox45wzb0M8rlipHbpDohr+E86xCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfDRWKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:10:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57004 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbfDRWKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 18:10:35 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3A1091C54;
        Thu, 18 Apr 2019 22:10:34 +0000 (UTC)
Date:   Thu, 18 Apr 2019 15:10:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] lib/test_vmalloc: do not create cpumask_t variable
 on stack
Message-Id: <20190418151033.9e46ec06c1d7482e6dee14bc@linux-foundation.org>
In-Reply-To: <20190418193925.9361-1-urezki@gmail.com>
References: <20190418193925.9361-1-urezki@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019 21:39:25 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> On my "Intel(R) Xeon(R) W-2135 CPU @ 3.70GHz" system(12 CPUs)
> i get the warning from the compiler about frame size:
> 
> <snip>
> warning: the frame size of 1096 bytes is larger than 1024 bytes
> [-Wframe-larger-than=]
> <snip>
> 
> the size of cpumask_t depends on number of CPUs, therefore just
> make use of cpumask_of() in set_cpus_allowed_ptr() as a second
> argument.
> 
> ...
L
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -383,14 +383,14 @@ static void shuffle_array(int *arr, int n)
>  static int test_func(void *private)
>  {
>  	struct test_driver *t = private;
> -	cpumask_t newmask = CPU_MASK_NONE;
>  	int random_array[ARRAY_SIZE(test_case_array)];
>  	int index, i, j, ret;
>  	ktime_t kt;
>  	u64 delta;
>  
> -	cpumask_set_cpu(t->cpu, &newmask);
> -	set_cpus_allowed_ptr(current, &newmask);
> +	ret = set_cpus_allowed_ptr(current, cpumask_of(t->cpu));
> +	if (ret < 0)
> +		pr_err("Failed to set affinity to %d CPU\n", t->cpu);
>  
>  	for (i = 0; i < ARRAY_SIZE(test_case_array); i++)
>  		random_array[i] = i;

lgtm.

While we're in there...


From: Andrew Morton <akpm@linux-foundation.org>
Subject: lib/test_vmalloc.c:test_func(): eliminate local `ret'

Local 'ret' is unneeded and was poorly named: the variable `ret' generally
means the "the value which this function will return".

Cc: Roman Gushchin <guro@fb.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/test_vmalloc.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/lib/test_vmalloc.c~a
+++ a/lib/test_vmalloc.c
@@ -384,12 +384,11 @@ static int test_func(void *private)
 {
 	struct test_driver *t = private;
 	int random_array[ARRAY_SIZE(test_case_array)];
-	int index, i, j, ret;
+	int index, i, j;
 	ktime_t kt;
 	u64 delta;
 
-	ret = set_cpus_allowed_ptr(current, cpumask_of(t->cpu));
-	if (ret < 0)
+	if (set_cpus_allowed_ptr(current, cpumask_of(t->cpu)) < 0)
 		pr_err("Failed to set affinity to %d CPU\n", t->cpu);
 
 	for (i = 0; i < ARRAY_SIZE(test_case_array); i++)
@@ -415,8 +414,7 @@ static int test_func(void *private)
 
 		kt = ktime_get();
 		for (j = 0; j < test_repeat_count; j++) {
-			ret = test_case_array[index].test_func();
-			if (!ret)
+			if (!test_case_array[index].test_func())
 				per_cpu_test_data[t->cpu][index].test_passed++;
 			else
 				per_cpu_test_data[t->cpu][index].test_failed++;
_


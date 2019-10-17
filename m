Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD77BFA3733
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C422082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="HvHf3Izc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502063AbfJQLMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:12:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34932 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406044AbfJQLMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:12:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so1562249lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 04:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e+UE2iGDqesmnvxFkXIP78kA9bYF2sHz3V0x23waWtc=;
        b=HvHf3IzcrrrG4G4r1sHAGC2cTy9BiF7AkIMd+OK7RQSNKTzngBnDuA0d2IFV/bTyX8
         6Xpfb8m0Kwl+YpE6SVyRlrHXiEq3yMcC2Rs6sCz6wYJxvEzzHrb6oMXA/+XFCJkKf7Ak
         R+rp8Cf2npuF8ClS0FpvCP8N0Yb/jJ4qOIl0LDzwRFqRFTae8Tv9Q9Hwg+WAYZ999ikF
         Y0UkUx3fFpPlBj7t9eGZW3V14wVtEDVWNtRvzyEdCuWWwBuvGODVOIbL+mHnfmohxpE3
         dB8H6oFvK7K76xc+OxtyoeIQBDGotTGBu3cNJFimTHK9WykmKJ/MQoxc3j4QKDNpHQAy
         qFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e+UE2iGDqesmnvxFkXIP78kA9bYF2sHz3V0x23waWtc=;
        b=BzZ7cbOJ4wZlVrug99NNvxt4nITYgJNii2RhjP1aAe7wCjm+FMPylrYUQS+v8XwlnJ
         7LeJzGqt42rnTmX4L8ubvC4rizXUgSqKtK4jAeFThpYiTK6y1ISBNqmryD1Bfe5T/Fom
         34B5MJd0yIFfy8p65ab2bCEVFs3Pph3j0CFIeOYCmuEJGzHecKksjw95RPxDHY9t7Wc/
         tk92UJdSct/+iDLU4HeWEahH1Pe7BnwG8klbskx/X+/803y9/s1w/C9mT3quo57ZoXXB
         UDL4wYu5Mme/1TxHfpc6aJ2ytQoQK3v4PKji3fWDaLn74ZJiGt6L1sRwath5F5OI0Rns
         p63w==
X-Gm-Message-State: APjAAAWIAiTDLyI3uabPOGWLnyHar/yTq0/UBAvfrPSQPGxLr6JTAv/F
        UsT2YhaqN4wfkHsawyktazhbYw==
X-Google-Smtp-Source: APXvYqxgt5AlzXb/YjsW9ibRJNADOXBX1WL7MwFPGRpB3B2aBWBoT4DxScrRRs0pFpkk/OIchLyyIQ==
X-Received: by 2002:ac2:4c29:: with SMTP id u9mr1681967lfq.143.1571310727224;
        Thu, 17 Oct 2019 04:12:07 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y2sm769882lfl.47.2019.10.17.04.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 04:12:06 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 51A581001A2; Thu, 17 Oct 2019 14:12:05 +0300 (+03)
Date:   Thu, 17 Oct 2019 14:12:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, keith.busch@intel.com
Subject: Re: [PATCH 1/4] node: Define and export memory migration path
Message-ID: <20191017111205.krurdatuv7d4brs4@box>
References: <20191016221148.F9CCD155@viggo.jf.intel.com>
 <20191016221149.74AE222C@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016221149.74AE222C@viggo.jf.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:11:49PM -0700, Dave Hansen wrote:
> 
> From: Keith Busch <keith.busch@intel.com>
> 
> Prepare for the kernel to auto-migrate pages to other memory nodes
> with a user defined node migration table. This allows creating single
> migration target for each NUMA node to enable the kernel to do NUMA
> page migrations instead of simply reclaiming colder pages. A node
> with no target is a "terminal node", so reclaim acts normally there.
> The migration target does not fundamentally _need_ to be a single node,
> but this implementation starts there to limit complexity.
> 
> If you consider the migration path as a graph, cycles (loops) in the
> graph are disallowed.  This avoids wasting resources by constantly
> migrating (A->B, B->A, A->B ...).  The expectation is that cycles will
> never be allowed, and this rule is enforced if the user tries to make
> such a cycle.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> 
>  b/drivers/base/node.c  |   73 +++++++++++++++++++++++++++++++++++++++++++++++++
>  b/include/linux/node.h |    6 ++++
>  2 files changed, 79 insertions(+)
> 
> diff -puN drivers/base/node.c~0003-node-Define-and-export-memory-migration-path drivers/base/node.c
> --- a/drivers/base/node.c~0003-node-Define-and-export-memory-migration-path	2019-10-16 15:06:55.895952599 -0700
> +++ b/drivers/base/node.c	2019-10-16 15:06:55.902952599 -0700
> @@ -101,6 +101,10 @@ static const struct attribute_group *nod
>  	NULL,
>  };
>  
> +#define TERMINAL_NODE -1

Wouldn't we have a confusion with NUMA_NO_NODE, which is also -1?

> +static int node_migration[MAX_NUMNODES] = {[0 ...  MAX_NUMNODES - 1] = TERMINAL_NODE};

This is the first time is see range initializer in kernel code. It is GCC
extension. Do we use it anywhere already?

Many distributions compile kernel with NODES_SHIFT==10, which means this
array will take 4k even on single node machine.

Should it be dynamic?

> +static DEFINE_SPINLOCK(node_migration_lock);
> +
>  static void node_remove_accesses(struct node *node)
>  {
>  	struct node_access_nodes *c, *cnext;
> @@ -530,6 +534,74 @@ static ssize_t node_read_distance(struct
>  }
>  static DEVICE_ATTR(distance, S_IRUGO, node_read_distance, NULL);
>  
> +static ssize_t migration_path_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	return sprintf(buf, "%d\n", node_migration[dev->id]);
> +}
> +
> +static ssize_t migration_path_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	int i, err, nid = dev->id;
> +	nodemask_t visited = NODE_MASK_NONE;
> +	long next;
> +
> +	err = kstrtol(buf, 0, &next);
> +	if (err)
> +		return -EINVAL;
> +
> +	if (next < 0) {

Any negative number to set it to terminal node? Why not limit it to -1?
We may find use for user negative numbers later.

> +		spin_lock(&node_migration_lock);
> +		WRITE_ONCE(node_migration[nid], TERMINAL_NODE);
> +		spin_unlock(&node_migration_lock);
> +		return count;
> +	}
> +	if (next >= MAX_NUMNODES || !node_online(next))
> +		return -EINVAL;

What prevents offlining after the check?

> +	/*
> +	 * Follow the entire migration path from 'nid' through the point where
> +	 * we hit a TERMINAL_NODE.
> +	 *
> +	 * Don't allow loops migration cycles in the path.
> +	 */
> +	node_set(nid, visited);
> +	spin_lock(&node_migration_lock);
> +	for (i = next; node_migration[i] != TERMINAL_NODE;
> +	     i = node_migration[i]) {
> +		/* Fail if we have visited this node already */
> +		if (node_test_and_set(i, visited)) {
> +			spin_unlock(&node_migration_lock);
> +			return -EINVAL;
> +		}
> +	}
> +	WRITE_ONCE(node_migration[nid], next);
> +	spin_unlock(&node_migration_lock);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(migration_path);
> +
> +/**
> + * next_migration_node() - Get the next node in the migration path
> + * @current_node: The starting node to lookup the next node
> + *
> + * @returns: node id for next memory node in the migration path hierarchy from
> + * 	     @current_node; -1 if @current_node is terminal or its migration
> + * 	     node is not online.
> + */
> +int next_migration_node(int current_node)
> +{
> +	int nid = READ_ONCE(node_migration[current_node]);
> +
> +	if (nid >= 0 && node_online(nid))
> +		return nid;
> +	return TERMINAL_NODE;
> +}
> +
>  static struct attribute *node_dev_attrs[] = {
>  	&dev_attr_cpumap.attr,
>  	&dev_attr_cpulist.attr,
> @@ -537,6 +609,7 @@ static struct attribute *node_dev_attrs[
>  	&dev_attr_numastat.attr,
>  	&dev_attr_distance.attr,
>  	&dev_attr_vmstat.attr,
> +	&dev_attr_migration_path.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(node_dev);
> diff -puN include/linux/node.h~0003-node-Define-and-export-memory-migration-path include/linux/node.h
> --- a/include/linux/node.h~0003-node-Define-and-export-memory-migration-path	2019-10-16 15:06:55.898952599 -0700
> +++ b/include/linux/node.h	2019-10-16 15:06:55.902952599 -0700
> @@ -134,6 +134,7 @@ static inline int register_one_node(int
>  	return error;
>  }
>  
> +extern int next_migration_node(int current_node);
>  extern void unregister_one_node(int nid);
>  extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
>  extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
> @@ -186,6 +187,11 @@ static inline void register_hugetlbfs_wi
>  						node_registration_func_t unreg)
>  {
>  }
> +
> +static inline int next_migration_node(int current_node)
> +{
> +	return -1;
> +}
>  #endif
>  
>  #define to_node(device) container_of(device, struct node, dev)
> _
> 

-- 
 Kirill A. Shutemov

Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F62C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8847A208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfCHQV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:21:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5225 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbfCHQV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:21:59 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 395418CC2C795FDAEE2B;
        Sat,  9 Mar 2019 00:21:55 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Sat, 9 Mar 2019
 00:21:49 +0800
Date:   Fri, 8 Mar 2019 16:21:39 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv7 06/10] node: Add memory-side caching attributes
Message-ID: <20190308162139.00004ed5@huawei.com>
In-Reply-To: <20190227225038.20438-7-keith.busch@intel.com>
References: <20190227225038.20438-1-keith.busch@intel.com>
        <20190227225038.20438-7-keith.busch@intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 15:50:34 -0700
Keith Busch <keith.busch@intel.com> wrote:

> System memory may have caches to help improve access speed to frequently
> requested address ranges. While the system provided cache is transparent
> to the software accessing these memory ranges, applications can optimize
> their own access based on cache attributes.
> 
> Provide a new API for the kernel to register these memory-side caches
> under the memory node that provides it.
> 
> The new sysfs representation is modeled from the existing cpu cacheinfo
> attributes, as seen from /sys/devices/system/cpu/<cpu>/cache/.  Unlike CPU
> cacheinfo though, the node cache level is reported from the view of the
> memory. A higher level number is nearer to the CPU, while lower levels
> are closer to the last level memory.
> 
> The exported attributes are the cache size, the line size, associativity
> indexing, and write back policy, and add the attributes for the system
> memory caches to sysfs stable documentation.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

One utterly trivial point inline that git am pointed out.

J
> ---
>  Documentation/ABI/stable/sysfs-devices-node |  34 +++++++
>  drivers/base/node.c                         | 151 ++++++++++++++++++++++++++++
>  include/linux/node.h                        |  39 +++++++
>  3 files changed, 224 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index 41cb9345e1e0..970fef47e6cd 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -142,3 +142,37 @@ Contact:	Keith Busch <keith.busch@intel.com>
>  Description:
>  		This node's write latency in nanoseconds when access
>  		from nodes found in this class's linked initiators.
> +
> +What:		/sys/devices/system/node/nodeX/memory_side_cache/indexY/
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		The directory containing attributes for the memory-side cache
> +		level 'Y'.
> +
> +What:		/sys/devices/system/node/nodeX/memory_side_cache/indexY/indexing
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		The caches associativity indexing: 0 for direct mapped,
> +		non-zero if indexed.
> +
> +What:		/sys/devices/system/node/nodeX/memory_side_cache/indexY/line_size
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		The number of bytes accessed from the next cache level on a
> +		cache miss.
> +
> +What:		/sys/devices/system/node/nodeX/memory_side_cache/indexY/size
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		The size of this memory side cache in bytes.
> +
> +What:		/sys/devices/system/node/nodeX/memory_side_cache/indexY/write_policy
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		The cache write policy: 0 for write-back, 1 for write-through,
> +		other or unknown.
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 2de546a040a5..8598fcbd2a17 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -205,6 +205,155 @@ void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
>  		}
>  	}
>  }
> +
> +/**
> + * struct node_cache_info - Internal tracking for memory node caches
> + * @dev:	Device represeting the cache level
> + * @node:	List element for tracking in the node
> + * @cache_attrs:Attributes for this cache level
> + */
> +struct node_cache_info {
> +	struct device dev;
> +	struct list_head node;
> +	struct node_cache_attrs cache_attrs;
> +};
> +#define to_cache_info(device) container_of(device, struct node_cache_info, dev)
> +
> +#define CACHE_ATTR(name, fmt) 						\
> +static ssize_t name##_show(struct device *dev,				\
> +			   struct device_attribute *attr,		\
> +			   char *buf)					\
> +{									\
> +	return sprintf(buf, fmt "\n", to_cache_info(dev)->cache_attrs.name);\
> +}									\
> +DEVICE_ATTR_RO(name);
> +
> +CACHE_ATTR(size, "%llu")
> +CACHE_ATTR(line_size, "%u")
> +CACHE_ATTR(indexing, "%u")
> +CACHE_ATTR(write_policy, "%u")
> +
> +static struct attribute *cache_attrs[] = {
> +	&dev_attr_indexing.attr,
> +	&dev_attr_size.attr,
> +	&dev_attr_line_size.attr,
> +	&dev_attr_write_policy.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(cache);
> +
> +static void node_cache_release(struct device *dev)
> +{
> +	kfree(dev);
> +}
> +
> +static void node_cacheinfo_release(struct device *dev)
> +{
> +	struct node_cache_info *info = to_cache_info(dev);
> +	kfree(info);
> +}
> +
> +static void node_init_cache_dev(struct node *node)
> +{
> +	struct device *dev;
> +
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return;
> +
> +	dev->parent = &node->dev;
> +	dev->release = node_cache_release;
> +	if (dev_set_name(dev, "memory_side_cache"))
> +		goto free_dev;
> +
> +	if (device_register(dev))
> +		goto free_name;
> +
> +	pm_runtime_no_callbacks(dev);
> +	node->cache_dev = dev;
> +	return;
> +free_name:
> +	kfree_const(dev->kobj.name);
> +free_dev:
> +	kfree(dev);
> +}
> +
> +/**
> + * node_add_cache() - add cache attribute to a memory node
> + * @nid: Node identifier that has new cache attributes
> + * @cache_attrs: Attributes for the cache being added
> + */
> +void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs)
> +{
> +	struct node_cache_info *info;
> +	struct device *dev;
> +	struct node *node;
> +
> +	if (!node_online(nid) || !node_devices[nid])
> +		return;
> +
> +	node = node_devices[nid];
> +	list_for_each_entry(info, &node->cache_attrs, node) {
> +		if (info->cache_attrs.level == cache_attrs->level) {
> +			dev_warn(&node->dev,
> +				"attempt to add duplicate cache level:%d\n",
> +				cache_attrs->level);
> +			return;
> +		}
> +	}
> +
> +	if (!node->cache_dev)
> +		node_init_cache_dev(node);
> +	if (!node->cache_dev)
> +		return;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return;
> +
> +	dev = &info->dev;
> +	dev->parent = node->cache_dev;
> +	dev->release = node_cacheinfo_release;
> +	dev->groups = cache_groups;
> +	if (dev_set_name(dev, "index%d", cache_attrs->level))
> +		goto free_cache;
> +
> +	info->cache_attrs = *cache_attrs;
> +	if (device_register(dev)) {
> +		dev_warn(&node->dev, "failed to add cache level:%d\n",
> +			 cache_attrs->level);
> +		goto free_name;
> +	}
> +	pm_runtime_no_callbacks(dev);
> +	list_add_tail(&info->node, &node->cache_attrs);
> +	return;
> +free_name:
> +	kfree_const(dev->kobj.name);
> +free_cache:
> +	kfree(info);
> +}
> +
> +static void node_remove_caches(struct node *node)
> +{
> +	struct node_cache_info *info, *next;
> +
> +	if (!node->cache_dev)
> +		return;
> +
> +	list_for_each_entry_safe(info, next, &node->cache_attrs, node) {
> +		list_del(&info->node);
> +		device_unregister(&info->dev);
> +	}
> +	device_unregister(node->cache_dev);
> +}
> +
> +static void node_init_caches(unsigned int nid)
> +{
> +	INIT_LIST_HEAD(&node_devices[nid]->cache_attrs);
> +}
> +#else
> +static void node_init_caches(unsigned int nid) { }
> +static void node_remove_caches(struct node *node) { }
>  #endif
>  
>  #define K(x) ((x) << (PAGE_SHIFT - 10))
> @@ -489,6 +638,7 @@ void unregister_node(struct node *node)
>  {
>  	hugetlb_unregister_node(node);		/* no-op, if memoryless node */
>  	node_remove_accesses(node);
> +	node_remove_caches(node);
>  	device_unregister(&node->dev);
>  }
>  
> @@ -781,6 +931,7 @@ int __register_one_node(int nid)
>  	INIT_LIST_HEAD(&node_devices[nid]->access_list);
>  	/* initialize work queue for memory hot plug */
>  	init_node_hugetlb_work(nid);
> +	node_init_caches(nid);
>  
>  	return error;
>  }
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 45e14e1e0c18..8fa350e01acc 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -35,10 +35,45 @@ struct node_hmem_attrs {
>  	unsigned int write_latency;
>  };
>  
> +enum cache_indexing {
> +	NODE_CACHE_DIRECT_MAP,
> +	NODE_CACHE_INDEXED,
> +	NODE_CACHE_OTHER,
> +};
> +
> +enum cache_write_policy {
> +	NODE_CACHE_WRITE_BACK,
> +	NODE_CACHE_WRITE_THROUGH,
> +	NODE_CACHE_WRITE_OTHER,
> +};
> +
> +/**
> + * struct node_cache_attrs - system memory caching attributes
> + *
> + * @indexing:		The ways memory blocks may be placed in cache
> + * @write_policy:	Write back or write through policy
> + * @size:		Total size of cache in bytes
> + * @line_size:		Number of bytes fetched on a cache miss
> + * @level:		The cache hierarchy level
> + */
> +struct node_cache_attrs {
> +	enum cache_indexing indexing;
> +	enum cache_write_policy write_policy;
> +	u64 size;
> +	u16 line_size;
> +	u8 level;
> +};
> +
>  #ifdef CONFIG_HMEM_REPORTING
> +void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs);
>  void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
>  			 unsigned access);
>  #else
> +static inline void node_add_cache(unsigned int nid,
> +				  struct node_cache_attrs *cache_attrs)
> +{
> +} 
There is a stray space at the end of the line above...

> +
>  static inline void node_set_perf_attrs(unsigned int nid,
>  				       struct node_hmem_attrs *hmem_attrs,
>  				       unsigned access)
> @@ -52,6 +87,10 @@ struct node {
>  #if defined(CONFIG_MEMORY_HOTPLUG_SPARSE) && defined(CONFIG_HUGETLBFS)
>  	struct work_struct	node_work;
>  #endif
> +#ifdef CONFIG_HMEM_REPORTING
> +	struct list_head cache_attrs;
> +	struct device *cache_dev;
> +#endif
>  };
>  
>  struct memory_block;



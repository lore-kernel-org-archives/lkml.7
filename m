Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C12C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1DF2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbfC0Wxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbfC0Wxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:53:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 075EC308FEDE;
        Wed, 27 Mar 2019 22:53:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBBC85D96F;
        Wed, 27 Mar 2019 22:53:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/01] vfs: Update mount API docs
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 27 Mar 2019 22:53:31 +0000
Message-ID: <155372719714.22541.5255255986435117253.stgit@warthog.procyon.org.uk>
In-Reply-To: <155372717431.22541.6255491459619152507.stgit@warthog.procyon.org.uk>
References: <155372717431.22541.6255491459619152507.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 27 Mar 2019 22:53:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the mount API docs to reflect recent changes to the code.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/mount_api.txt |  367 ++++++++++++++++---------------
 1 file changed, 195 insertions(+), 172 deletions(-)

diff --git a/Documentation/filesystems/mount_api.txt b/Documentation/filesystems/mount_api.txt
index 944d1965e917..6a902767bf27 100644
--- a/Documentation/filesystems/mount_api.txt
+++ b/Documentation/filesystems/mount_api.txt
@@ -12,11 +12,13 @@ CONTENTS
 
  (4) Filesystem context security.
 
- (5) VFS filesystem context operations.
+ (5) VFS filesystem context API.
 
- (6) Parameter description.
+ (6) Superblock creation helpers.
 
- (7) Parameter helper functions.
+ (7) Parameter description.
+
+ (8) Parameter helper functions.
 
 
 ========
@@ -41,12 +43,15 @@ The creation of new mounts is now to be done in a multistep process:
 
  (7) Destroy the context.
 
-To support this, the file_system_type struct gains a new field:
+To support this, the file_system_type struct gains two new fields:
 
 	int (*init_fs_context)(struct fs_context *fc);
+	const struct fs_parameter_description *parameters;
 
-which is invoked to set up the filesystem-specific parts of a filesystem
-context, including the additional space.
+The first is invoked to set up the filesystem-specific parts of a filesystem
+context, including the additional space, and the second points to the
+parameter description for validation at registration time and querying by a
+future system call.
 
 Note that security initialisation is done *after* the filesystem is called so
 that the namespaces may be adjusted first.
@@ -73,9 +78,9 @@ context.  This is represented by the fs_context structure:
 		void			*s_fs_info;
 		unsigned int		sb_flags;
 		unsigned int		sb_flags_mask;
+		unsigned int		s_iflags;
+		unsigned int		lsm_flags;
 		enum fs_context_purpose	purpose:8;
-		bool			sloppy:1;
-		bool			silent:1;
 		...
 	};
 
@@ -141,6 +146,10 @@ The fs_context fields are as follows:
 
      Which bits SB_* flags are to be set/cleared in super_block::s_flags.
 
+ (*) unsigned int s_iflags
+
+     These will be bitwise-OR'd with s->s_iflags when a superblock is created.
+
  (*) enum fs_context_purpose
 
      This indicates the purpose for which the context is intended.  The
@@ -150,17 +159,6 @@ The fs_context fields are as follows:
 	FS_CONTEXT_FOR_SUBMOUNT		-- New automatic submount of extant mount
 	FS_CONTEXT_FOR_RECONFIGURE	-- Change an existing mount
 
- (*) bool sloppy
- (*) bool silent
-
-     These are set if the sloppy or silent mount options are given.
-
-     [NOTE] sloppy is probably unnecessary when userspace passes over one
-     option at a time since the error can just be ignored if userspace deems it
-     to be unimportant.
-
-     [NOTE] silent is probably redundant with sb_flags & SB_SILENT.
-
 The mount context is created by calling vfs_new_fs_context() or
 vfs_dup_fs_context() and is destroyed with put_fs_context().  Note that the
 structure is not refcounted.
@@ -342,28 +340,47 @@ number of operations used by the new mount code for this purpose:
      It should return 0 on success or a negative error code on failure.
 
 
-=================================
-VFS FILESYSTEM CONTEXT OPERATIONS
-=================================
+==========================
+VFS FILESYSTEM CONTEXT API
+==========================
 
-There are four operations for creating a filesystem context and
-one for destroying a context:
+There are four operations for creating a filesystem context and one for
+destroying a context:
 
- (*) struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
-					   struct dentry *reference,
-					   unsigned int sb_flags,
-					   unsigned int sb_flags_mask,
-					   enum fs_context_purpose purpose);
+ (*) struct fs_context *fs_context_for_mount(
+		struct file_system_type *fs_type,
+		unsigned int sb_flags);
 
-     Create a filesystem context for a given filesystem type and purpose.  This
-     allocates the filesystem context, sets the superblock flags, initialises
-     the security and calls fs_type->init_fs_context() to initialise the
-     filesystem private data.
+     Allocate a filesystem context for the purpose of setting up a new mount,
+     whether that be with a new superblock or sharing an existing one.  This
+     sets the superblock flags, initialises the security and calls
+     fs_type->init_fs_context() to initialise the filesystem private data.
 
-     reference can be NULL or it may indicate the root dentry of a superblock
-     that is going to be reconfigured (FS_CONTEXT_FOR_RECONFIGURE) or
-     the automount point that triggered a submount (FS_CONTEXT_FOR_SUBMOUNT).
-     This is provided as a source of namespace information.
+     fs_type specifies the filesystem type that will manage the context and
+     sb_flags presets the superblock flags stored therein.
+
+ (*) struct fs_context *fs_context_for_reconfigure(
+		struct dentry *dentry,
+		unsigned int sb_flags,
+		unsigned int sb_flags_mask);
+
+     Allocate a filesystem context for the purpose of reconfiguring an
+     existing superblock.  dentry provides a reference to the superblock to be
+     configured.  sb_flags and sb_flags_mask indicate which superblock flags
+     need changing and to what.
+
+ (*) struct fs_context *fs_context_for_submount(
+		struct file_system_type *fs_type,
+		struct dentry *reference);
+
+     Allocate a filesystem context for the purpose of creating a new mount for
+     an automount point or other derived superblock.  fs_type specifies the
+     filesystem type that will manage the context and the reference dentry
+     supplies the parameters.  Namespaces are propagated from the reference
+     dentry's superblock also.
+
+     Note that it's not a requirement that the reference dentry be of the same
+     filesystem type as fs_type.
 
  (*) struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc);
 
@@ -390,20 +407,6 @@ context pointer or a negative error code.
 For the remaining operations, if an error occurs, a negative error code will be
 returned.
 
- (*) int vfs_get_tree(struct fs_context *fc);
-
-     Get or create the mountable root and superblock, using the parameters in
-     the filesystem context to select/configure the superblock.  This invokes
-     the ->validate() op and then the ->get_tree() op.
-
-     [NOTE] ->validate() could perhaps be rolled into ->get_tree() and
-     ->reconfigure().
-
- (*) struct vfsmount *vfs_create_mount(struct fs_context *fc);
-
-     Create a mount given the parameters in the specified filesystem context.
-     Note that this does not attach the mount to anything.
-
  (*) int vfs_parse_fs_param(struct fs_context *fc,
 			    struct fs_parameter *param);
 
@@ -432,17 +435,80 @@ returned.
      clear the pointer, but then becomes responsible for disposing of the
      object.
 
- (*) int vfs_parse_fs_string(struct fs_context *fc, char *key,
+ (*) int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 			     const char *value, size_t v_size);
 
-     A wrapper around vfs_parse_fs_param() that just passes a constant string.
+     A wrapper around vfs_parse_fs_param() that copies the value string it is
+     passed.
 
  (*) int generic_parse_monolithic(struct fs_context *fc, void *data);
 
      Parse a sys_mount() data page, assuming the form to be a text list
      consisting of key[=val] options separated by commas.  Each item in the
      list is passed to vfs_mount_option().  This is the default when the
-     ->parse_monolithic() operation is NULL.
+     ->parse_monolithic() method is NULL.
+
+ (*) int vfs_get_tree(struct fs_context *fc);
+
+     Get or create the mountable root and superblock, using the parameters in
+     the filesystem context to select/configure the superblock.  This invokes
+     the ->get_tree() method.
+
+ (*) struct vfsmount *vfs_create_mount(struct fs_context *fc);
+
+     Create a mount given the parameters in the specified filesystem context.
+     Note that this does not attach the mount to anything.
+
+
+===========================
+SUPERBLOCK CREATION HELPERS
+===========================
+
+A number of VFS helpers are available for use by filesystems for the creation
+or looking up of superblocks.
+
+ (*) struct super_block *
+     sget_fc(struct fs_context *fc,
+	     int (*test)(struct super_block *sb, struct fs_context *fc),
+	     int (*set)(struct super_block *sb, struct fs_context *fc));
+
+     This is the core routine.  If test is non-NULL, it searches for an
+     existing superblock matching the criteria held in the fs_context, using
+     the test function to match them.  If no match is found, a new superblock
+     is created and the set function is called to set it up.
+
+     Prior to the set function being called, fc->s_fs_info will be transferred
+     to sb->s_fs_info - and fc->s_fs_info will be cleared if set returns
+     success (ie. 0).
+
+The following helpers all wrap sget_fc():
+
+ (*) int vfs_get_super(struct fs_context *fc,
+		       enum vfs_get_super_keying keying,
+		       int (*fill_super)(struct super_block *sb,
+					 struct fs_context *fc))
+
+     This creates/looks up a deviceless superblock.  The keying indicates how
+     many superblocks of this type may exist and in what manner they may be
+     shared:
+
+	(1) vfs_get_single_super
+
+	    Only one such superblock may exist in the system.  Any further
+	    attempt to get a new superblock gets this one (and any parameter
+	    differences are ignored).
+
+	(2) vfs_get_keyed_super
+
+	    Multiple superblocks of this type may exist and they're keyed on
+	    their s_fs_info pointer (for example this may refer to a
+	    namespace).
+
+	(3) vfs_get_independent_super
+
+	    Multiple independent superblocks of this type may exist.  This
+	    function never matches an existing one and always creates a new
+	    one.
 
 
 =====================
@@ -454,35 +520,22 @@ There's a core description struct that links everything together:
 
 	struct fs_parameter_description {
 		const char	name[16];
-		u8		nr_params;
-		u8		nr_alt_keys;
-		u8		nr_enums;
-		bool		ignore_unknown;
-		bool		no_source;
-		const char *const *keys;
-		const struct constant_table *alt_keys;
 		const struct fs_parameter_spec *specs;
 		const struct fs_parameter_enum *enums;
 	};
 
 For example:
 
-	enum afs_param {
+	enum {
 		Opt_autocell,
 		Opt_bar,
 		Opt_dyn,
 		Opt_foo,
 		Opt_source,
-		nr__afs_params
 	};
 
 	static const struct fs_parameter_description afs_fs_parameters = {
 		.name		= "kAFS",
-		.nr_params	= nr__afs_params,
-		.nr_alt_keys	= ARRAY_SIZE(afs_param_alt_keys),
-		.nr_enums	= ARRAY_SIZE(afs_param_enums),
-		.keys		= afs_param_keys,
-		.alt_keys	= afs_param_alt_keys,
 		.specs		= afs_param_specs,
 		.enums		= afs_param_enums,
 	};
@@ -494,28 +547,24 @@ The members are as follows:
      The name to be used in error messages generated by the parse helper
      functions.
 
- (2) u8 nr_params;
-
-     The number of discrete parameter identifiers.  This indicates the number
-     of elements in the ->types[] array and also limits the values that may be
-     used in the values that the ->keys[] array maps to.
-
-     It is expected that, for example, two parameters that are related, say
-     "acl" and "noacl" with have the same ID, but will be flagged to indicate
-     that one is the inverse of the other.  The value can then be picked out
-     from the parse result.
+ (2) const struct fs_parameter_specification *specs;
 
- (3) const struct fs_parameter_specification *specs;
+     Table of parameter specifications, terminated with a null entry, where the
+     entries are of type:
 
-     Table of parameter specifications, where the entries are of type:
-
-	struct fs_parameter_type {
-		enum fs_parameter_spec	type:8;
-		u8			flags;
+	struct fs_parameter_spec {
+		const char		*name;
+		u8			opt;
+		enum fs_parameter_type	type:8;
+		unsigned short		flags;
 	};
 
-     and the parameter identifier is the index to the array.  'type' indicates
-     the desired value type and must be one of:
+     The 'name' field is a string to match exactly to the parameter key (no
+     wildcards, patterns and no case-independence) and 'opt' is the value that
+     will be returned by the fs_parser() function in the case of a successful
+     match.
+
+     The 'type' field indicates the desired value type and must be one of:
 
 	TYPE NAME		EXPECTED VALUE		RESULT IN
 	=======================	=======================	=====================
@@ -525,85 +574,65 @@ The members are as follows:
 	fs_param_is_u32_octal	32-bit octal int	result->uint_32
 	fs_param_is_u32_hex	32-bit hex int		result->uint_32
 	fs_param_is_s32		32-bit signed int	result->int_32
+	fs_param_is_u64		64-bit unsigned int	result->uint_64
 	fs_param_is_enum	Enum value name 	result->uint_32
 	fs_param_is_string	Arbitrary string	param->string
 	fs_param_is_blob	Binary blob		param->blob
 	fs_param_is_blockdev	Blockdev path		* Needs lookup
 	fs_param_is_path	Path			* Needs lookup
-	fs_param_is_fd		File descriptor		param->file
-
-     And each parameter can be qualified with 'flags':
-
-     	fs_param_v_optional	The value is optional
-	fs_param_neg_with_no	If key name is prefixed with "no", it is false
-	fs_param_neg_with_empty	If value is "", it is false
-	fs_param_deprecated	The parameter is deprecated.
-
-     For example:
-
-	static const struct fs_parameter_spec afs_param_specs[nr__afs_params] = {
-		[Opt_autocell]	= { fs_param_is flag },
-		[Opt_bar]	= { fs_param_is_enum },
-		[Opt_dyn]	= { fs_param_is flag },
-		[Opt_foo]	= { fs_param_is_bool, fs_param_neg_with_no },
-		[Opt_source]	= { fs_param_is_string },
-	};
+	fs_param_is_fd		File descriptor		result->int_32
 
      Note that if the value is of fs_param_is_bool type, fs_parse() will try
      to match any string value against "0", "1", "no", "yes", "false", "true".
 
-     [!] NOTE that the table must be sorted according to primary key name so
-     	 that ->keys[] is also sorted.
-
- (4) const char *const *keys;
-
-     Table of primary key names for the parameters.  There must be one entry
-     per defined parameter.  The table is optional if ->nr_params is 0.  The
-     table is just an array of names e.g.:
-
-	static const char *const afs_param_keys[nr__afs_params] = {
-		[Opt_autocell]	= "autocell",
-		[Opt_bar]	= "bar",
-		[Opt_dyn]	= "dyn",
-		[Opt_foo]	= "foo",
-		[Opt_source]	= "source",
-	};
-
-     [!] NOTE that the table must be sorted such that the table can be searched
-     	 with bsearch() using strcmp().  This means that the Opt_* values must
-     	 correspond to the entries in this table.
-
- (5) const struct constant_table *alt_keys;
-     u8 nr_alt_keys;
+     Each parameter can also be qualified with 'flags':
 
-     Table of additional key names and their mappings to parameter ID plus the
-     number of elements in the table.  This is optional.  The table is just an
-     array of { name, integer } pairs, e.g.:
+     	fs_param_v_optional	The value is optional
+	fs_param_neg_with_no	result->negated set if key is prefixed with "no"
+	fs_param_neg_with_empty	result->negated set if value is ""
+	fs_param_deprecated	The parameter is deprecated.
 
-	static const struct constant_table afs_param_keys[] = {
-		{ "baz",	Opt_bar },
-		{ "dynamic",	Opt_dyn },
+     These are wrapped with a number of convenience wrappers:
+
+	MACRO			SPECIFIES
+	=======================	===============================================
+	fsparam_flag()		fs_param_is_flag
+	fsparam_flag_no()	fs_param_is_flag, fs_param_neg_with_no
+	fsparam_bool()		fs_param_is_bool
+	fsparam_u32()		fs_param_is_u32
+	fsparam_u32oct()	fs_param_is_u32_octal
+	fsparam_u32hex()	fs_param_is_u32_hex
+	fsparam_s32()		fs_param_is_s32
+	fsparam_u64()		fs_param_is_u64
+	fsparam_enum()		fs_param_is_enum
+	fsparam_string()	fs_param_is_string
+	fsparam_blob()		fs_param_is_blob
+	fsparam_bdev()		fs_param_is_blockdev
+	fsparam_path()		fs_param_is_path
+	fsparam_fd()		fs_param_is_fd
+
+     all of which take two arguments, name string and option number - for
+     example:
+
+	static const struct fs_parameter_spec afs_param_specs[] = {
+		fsparam_flag	("autocell",	Opt_autocell),
+		fsparam_flag	("dyn",		Opt_dyn),
+		fsparam_string	("source",	Opt_source),
+		fsparam_flag_no	("foo",		Opt_foo),
+		{}
 	};
 
-     [!] NOTE that the table must be sorted such that strcmp() can be used with
-     	 bsearch() to search the entries.
-
-     The parameter ID can also be fs_param_key_removed to indicate that a
-     deprecated parameter has been removed and that an error will be given.
-     This differs from fs_param_deprecated where the parameter may still have
-     an effect.
-
-     Further, the behaviour of the parameter may differ when an alternate name
-     is used (for instance with NFS, "v3", "v4.2", etc. are alternate names).
+     An addition macro, __fsparam() is provided that takes an additional pair
+     of arguments to specify the type and the flags for anything that doesn't
+     match one of the above macros.
 
  (6) const struct fs_parameter_enum *enums;
-     u8 nr_enums;
 
-     Table of enum value names to integer mappings and the number of elements
-     stored therein.  This is of type:
+     Table of enum value names to integer mappings, terminated with a null
+     entry.  This is of type:
 
 	struct fs_parameter_enum {
-		u8		param_id;
+		u8		opt;
 		char		name[14];
 		u8		value;
 	};
@@ -621,11 +650,6 @@ The members are as follows:
      try to look the value up in the enum table and the result will be stored
      in the parse result.
 
- (7) bool no_source;
-
-     If this is set, fs_parse() will ignore any "source" parameter and not
-     pass it to the filesystem.
-
 The parser should be pointed to by the parser pointer in the file_system_type
 struct as this will provide validation on registration (if
 CONFIG_VALIDATE_FS_PARSER=y) and will allow the description to be queried from
@@ -650,9 +674,8 @@ process the parameters it is given.
 		int		value;
 	};
 
-     and it must be sorted such that it can be searched using bsearch() using
-     strcmp().  If a match is found, the corresponding value is returned.  If a
-     match isn't found, the not_found value is returned instead.
+     If a match is found, the corresponding value is returned.  If a match
+     isn't found, the not_found value is returned instead.
 
  (*) bool validate_constant_table(const struct constant_table *tbl,
 				  size_t tbl_size,
@@ -665,36 +688,36 @@ process the parameters it is given.
      should just be set to lie inside the low-to-high range.
 
      If all is good, true is returned.  If the table is invalid, errors are
-     logged to dmesg, the stack is dumped and false is returned.
+     logged to dmesg and false is returned.
+
+ (*) bool fs_validate_description(const struct fs_parameter_description *desc);
+
+     This performs some validation checks on a parameter description.  It
+     returns true if the description is good and false if it is not.  It will
+     log errors to dmesg if validation fails.
 
  (*) int fs_parse(struct fs_context *fc,
-		  const struct fs_param_parser *parser,
+		  const struct fs_parameter_description *desc,
 		  struct fs_parameter *param,
-		  struct fs_param_parse_result *result);
+		  struct fs_parse_result *result);
 
      This is the main interpreter of parameters.  It uses the parameter
-     description (parser) to look up the name of the parameter to use and to
-     convert that to a parameter ID (stored in result->key).
+     description to look up a parameter by key name and to convert that to an
+     option number (which it returns).
 
      If successful, and if the parameter type indicates the result is a
      boolean, integer or enum type, the value is converted by this function and
-     the result stored in result->{boolean,int_32,uint_32}.
+     the result stored in result->{boolean,int_32,uint_32,uint_64}.
 
      If a match isn't initially made, the key is prefixed with "no" and no
      value is present then an attempt will be made to look up the key with the
      prefix removed.  If this matches a parameter for which the type has flag
-     fs_param_neg_with_no set, then a match will be made and the value will be
-     set to false/0/NULL.
-
-     If the parameter is successfully matched and, optionally, parsed
-     correctly, 1 is returned.  If the parameter isn't matched and
-     parser->ignore_unknown is set, then 0 is returned.  Otherwise -EINVAL is
-     returned.
-
- (*) bool fs_validate_description(const struct fs_parameter_description *desc);
+     fs_param_neg_with_no set, then a match will be made and result->negated
+     will be set to true.
 
-     This is validates the parameter description.  It returns true if the
-     description is good and false if it is not.
+     If the parameter isn't matched, -ENOPARAM will be returned; if the
+     parameter is matched, but the value is erroneous, -EINVAL will be
+     returned; otherwise the parameter's option number will be returned.
 
  (*) int fs_lookup_param(struct fs_context *fc,
 			 struct fs_parameter *value,

